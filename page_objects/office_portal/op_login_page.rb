# frozen_string_literal: true

require_relative '../base_page'

#OPLoginPage objects
class OPLoginPage < BasePage
  include EnvUtils

  OP_LOGIN = {
    company_logo: "//img[@class='company-logo-img']",
    app_logo: "//div[@id='background_branding_container']//img[@class='app-logo']",
    portal_name: "//div[@id='background_branding_container']//img[@class='app-logo']/following-sibling::span",
    login_heading: "//h1[@class='reset-password-heading']",
    unregistered_error: "//div[@class='error pageLevel']",
    email_heading: "//label[contains(text(),'Email')]",
    email_error: "//label[contains(text(),'Email')]/following-sibling::div/p",
    email_field: "//input[@type='email']",
    password_heading: "//label[contains(text(),'Password')]",
    forgot_password_link: "//a[@id='forgotPassword']",
    password_error: "//div[@class='password-label']/following-sibling::div/p",
    password_field: "//input[@type='password']",
    sign_in_btn: "//button[@type='submit']",
    page_footer: "//footer[contains(text(),'SOL-X Pte.')]"
  }.freeze

  VALID_CREDS = {
    email: 'qa-test-group@sol-x.co',
    password: 'Solxqa12345!'
  }.freeze

  def open_op_page
    @driver.manage.timeouts.page_load = 15
    @driver.get(retrieve_env_url)
    find_element(OP_LOGIN[:login_heading])
    @driver.manage.timeouts.page_load = TIMEOUT
  end

  def verify_login_page_attributes
    verify_logos_and_names
    verify_email_block
    verify_password_block
  end

  def enter_text(text, field)
    case field
    when 'Email'
      element = @driver.find_element(xpath: OP_LOGIN[:email_field])
    when 'Password'
      element = @driver.find_element(xpath: OP_LOGIN[:password_field])
    else
      raise "#{field} field is not expected"
    end
    enter_creds_in_field(text, element, field)
  end

  def click_sign_in
    click(OP_LOGIN[:sign_in_btn])
  end

  def verify_error_message(message, place)
    actual_message = retrieve_error_message(place)
    compare_string(message, actual_message)
  end

  def verify_highlighted_in_red(field)
    case field
    when 'Email'
      element = @driver.find_element(xpath: OP_LOGIN[:email_field])
    when 'Password'
      element = @driver.find_element(xpath: OP_LOGIN[:password_field])
    else
      raise "#{field} field is not expected"
    end
    border_colour = element.css_value('border-color')
    compare_string('rgb(216, 75, 75)', border_colour)
  end

  private

  def verify_logos_and_names
    find_element(OP_LOGIN[:company_logo])
    find_element(OP_LOGIN[:app_logo])
    actual_name = retrieve_text(OP_LOGIN[:portal_name])
    actual_heading = retrieve_text(OP_LOGIN[:login_heading])
    actual_footer = retrieve_text(OP_LOGIN[:page_footer])
    compare_string('Office Portal', actual_name)
    compare_string('Log in', actual_heading)
    compare_string('© 2021 SOL-X Pte. Ltd. All Rights Reserved', actual_footer)
  end

  def verify_email_block
    actual_name = retrieve_text(OP_LOGIN[:email_heading])
    email_field = @driver.find_element(xpath: OP_LOGIN[:email_field])
    actual_placeholder = email_field.attribute('placeholder')
    compare_string('Email', actual_name)
    compare_string('Required', actual_placeholder)
  end

  def verify_password_block
    actual_name = retrieve_text(OP_LOGIN[:password_heading])
    link_name = retrieve_text(OP_LOGIN[:forgot_password_link])
    password_field = @driver.find_element(xpath: OP_LOGIN[:password_field])
    actual_placeholder = password_field.attribute('placeholder')
    compare_string('Password', actual_name)
    compare_string('Forgot Password?', link_name)
    compare_string('Required', actual_placeholder)
  end

  def retrieve_error_message(heading)
    case heading
    when 'Log in'
      retrieve_text(OP_LOGIN[:unregistered_error])
    when 'Email'
      retrieve_text(OP_LOGIN[:email_error])
    when 'Password'
      retrieve_text(OP_LOGIN[:password_error])
    else
      raise "#{heading} heading is not expected"
    end
  end

  def enter_creds_in_field(creds, element, field)
    if creds == 'valid_creds'
      element.send_keys(VALID_CREDS[:"#{field.downcase}"])
    else
      element.send_keys(creds)
    end
  end
end
