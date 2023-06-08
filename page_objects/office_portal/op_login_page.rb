# frozen_string_literal: true

require_relative '../base_page'

# OPLoginPage objects
class OPLoginPage < BasePage
  include EnvUtils

  OP_LOGIN = {
    company_logo: "//img[@class='company-logo-img']",
    app_logo: "//div[@id='background_branding_container']//img[@class='app-logo']",
    portal_name: "//div[@id='background_branding_container']//img[@class='app-logo']/following-sibling::span",
    login_heading: "//h1[@class='reset-password-heading']",
    login_error: "//div[@class='error pageLevel']",
    email_heading: "//label[contains(text(),'Email')]",
    email_error: "//label[contains(text(),'Email')]/following-sibling::div/p",
    email_field: "//input[@id='signInName']",
    password_heading: "//label[contains(text(),'Password')]",
    forgot_password_link: "//a[@id='forgotPassword']",
    password_error: "//div[@class='password-label']/following-sibling::div/p",
    password_field: "//input[@type='password']",
    sign_in_btn: "//button[@type='submit']",
    page_footer: "//footer[contains(text(),'SOL-X Pte.')]"
  }.freeze

  def open_op_page
    @driver.get(retrieve_env_url)
    find_element(OP_LOGIN[:login_heading])
  end

  def verify_login_page_attributes
    verify_logos
    verify_names
    verify_email_block
    verify_password_block
  end

  def enter_password(text)
    enter_text(OP_LOGIN[:password_field], text)
  end

  def enter_email(text)
    enter_text(OP_LOGIN[:email_field], text)
  end

  def click_sign_in
    click(OP_LOGIN[:sign_in_btn])
  end

  def click_forgot_password
    click(OP_LOGIN[:forgot_password_link])
  end

  def verify_error_message(table)
    table.hashes.each do |sub_table|
      actual_message = retrieve_error_message(sub_table['heading'])
      compare_string(sub_table['message'], actual_message)
    end
  end

  def verify_highlighted_in_red(field)
    xpath_key = "#{field.downcase}_field".to_sym
    element = find_element(OP_LOGIN[xpath_key])
    border_colour = element.css_value('border-color')
    compare_string('rgb(216, 75, 75)', border_colour)
  end

  def remove_password
    element = OP_LOGIN[:password_field]
    enter_text(element, "\ue003") until retrieve_text(element).empty?
  end

  private

  def verify_logos
    find_element(OP_LOGIN[:company_logo])
    find_element(OP_LOGIN[:app_logo])
  end

  def verify_names
    portal_name = YAML.load_file('data/office-portal/common_items.yml')['portal_name']
    portal_footer = YAML.load_file('data/office-portal/common_items.yml')['portal_footer']
    compare_string(portal_name, retrieve_text(OP_LOGIN[:portal_name]))
    compare_string('Log in', retrieve_text(OP_LOGIN[:login_heading]))
    compare_string(portal_footer, retrieve_text(OP_LOGIN[:page_footer]))
  end

  def verify_email_block
    portal_placeholder = YAML.load_file('data/office-portal/common_items.yml')['portal_placeholder']
    email_field = find_element(OP_LOGIN[:email_field])
    actual_placeholder = email_field.attribute('placeholder')
    compare_string('Email', retrieve_text(OP_LOGIN[:email_heading]))
    compare_string(portal_placeholder, actual_placeholder)
  end

  def verify_password_block
    portal_placeholder = YAML.load_file('data/office-portal/common_items.yml')['portal_placeholder']
    password_field = find_element(OP_LOGIN[:password_field])
    actual_placeholder = password_field.attribute('placeholder')
    compare_string('Password', retrieve_text(OP_LOGIN[:password_heading]))
    compare_string('Forgot Password?', retrieve_text(OP_LOGIN[:forgot_password_link]))
    compare_string(portal_placeholder, actual_placeholder)
  end

  def retrieve_error_message(heading)
    xpath_key = "#{heading.downcase}_error".to_sym
    retrieve_text(OP_LOGIN[xpath_key])
  end
end
