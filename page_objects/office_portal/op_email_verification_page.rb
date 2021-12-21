# frozen_string_literal: true

require_relative '../base_page'

#OPEmailVerificationPage objects
class OPEmailVerificationPage < BasePage
  include EnvUtils
  OP_EMAIL_VERIFICATION = {
    company_logo: "//img[@class='company-logo-img']",
    app_logo: "//div[@id='background_branding_container']//img[@class='app-logo']",
    portal_name: "//div[@id='background_branding_container']//img[@class='app-logo']/following-sibling::span",
    account_heading: "//h1[@class='reset-password-heading']",
    account_description: "//div[@class='verificationSuccessText']",
    account_error: "//div[@id='emailVerificationControl_error_message']",
    email_heading: "//label[contains(text(),'Email')]",
    email_error: "//label[contains(text(),'Email')]/following-sibling::div",
    email_field: "//input[@id='email']",
    verification_heading: "//label[contains(text(),'Verification Code')]",
    verification_error: "//label[contains(text(),'Verification Code')]/following-sibling::div",
    verification_code_field: "//input[@id='emailVerificationCode']",
    cancel_btn: "//button[contains(text(),'Cancel')]",
    send_code_btn: "//button[contains(text(),'Send verification code')]",
    verify_code_btn: "//button[contains(text(),'Verify code')]",
    resend_code_btn: "//button[contains(text(),'Send new code')]",
    page_footer: "//footer[contains(text(),'SOL-X Pte.')]"
  }.freeze

  def initialize(driver)
    super
    find_element(OP_EMAIL_VERIFICATION[:send_code_btn])
  end

  def verify_verification_page_attributes
    find_element(OP_EMAIL_VERIFICATION[:cancel_btn])
    find_element(OP_EMAIL_VERIFICATION[:send_code_btn])
    verify_logos_and_names
    verify_email_block
  end

  def verify_additional_elements
    description = YAML.load_file('data/office-portal/common_items.yml')['verification_code_description']
    actual_description = retrieve_text(OP_EMAIL_VERIFICATION[:account_description])
    compare_string(description, actual_description)
    find_element(OP_EMAIL_VERIFICATION[:verify_code_btn])
    verify_code_block
  end

  def click_cancel
    click(OP_EMAIL_VERIFICATION[:cancel_btn])
  end

  def click_send_code
    click(OP_EMAIL_VERIFICATION[:send_code_btn])
  end

  def click_send_new_code
    click(OP_EMAIL_VERIFICATION[:resend_code_btn])
  end

  def click_verify_code
    click(OP_EMAIL_VERIFICATION[:verify_code_btn])
  end

  def verify_error_message(table)
    table.hashes.each do |sub_table|
      actual_message = retrieve_error_message(sub_table['heading'])
      compare_string(sub_table['message'], actual_message)
    end
  end

  def enter_email(text)
    enter_text(OP_EMAIL_VERIFICATION[:email_field], text)
  end

  def verify_email_entered(text)
    email = find_element(OP_EMAIL_VERIFICATION[:email_field])
    entered_email = email.attribute('value')
    compare_string(text, entered_email)
  end

  def verify_field_exists(field)
    find_element(OP_EMAIL_VERIFICATION[:"#{field.to_sym}_field"])
  end

  def enter_verification_code(code)
    enter_text(OP_EMAIL_VERIFICATION[:verification_code_field], code)
  end

  def remove_email_character
    enter_text(OP_EMAIL_VERIFICATION[:email_field], "\ue003")
  end

  def verify_page_header
    compare_string('Account Verification', retrieve_text(OP_EMAIL_VERIFICATION[:account_heading]))
  end

  private

  def verify_logos_and_names
    find_element(OP_EMAIL_VERIFICATION[:company_logo])
    find_element(OP_EMAIL_VERIFICATION[:app_logo])
    expected_items = YAML.load_file('data/office-portal/common_items.yml')
    compare_string(expected_items['portal_name'], retrieve_text(OP_EMAIL_VERIFICATION[:portal_name]))
    compare_string('Account Verification', retrieve_text(OP_EMAIL_VERIFICATION[:account_heading]))
    compare_string(expected_items['portal_footer'], retrieve_text(OP_EMAIL_VERIFICATION[:page_footer]))
end

  def verify_email_block
    portal_placeholder = YAML.load_file('data/office-portal/common_items.yml')['portal_placeholder']
    email_field = find_element(OP_EMAIL_VERIFICATION[:email_field])
    actual_placeholder = email_field.attribute('placeholder')
    compare_string('Email', retrieve_text(OP_EMAIL_VERIFICATION[:email_heading]))
    compare_string(portal_placeholder, actual_placeholder)
  end

  def verify_code_block
    portal_placeholder = YAML.load_file('data/office-portal/common_items.yml')['portal_placeholder']
    verification_code_field = find_element(OP_EMAIL_VERIFICATION[:verification_code_field])
    actual_placeholder = verification_code_field.attribute('placeholder')
    field_heading = retrieve_text(OP_EMAIL_VERIFICATION[:verification_heading])
    real_heading = field_heading.sub('Resend code', '').chomp
    compare_string('Verification Code', real_heading)
    compare_string('Resend code', retrieve_text(OP_EMAIL_VERIFICATION[:resend_code_btn]))
    compare_string(portal_placeholder, actual_placeholder)
  end

  def retrieve_error_message(heading)
    xpath_key = "#{heading.downcase}_error".to_sym
    retrieve_text(OP_EMAIL_VERIFICATION[xpath_key])
  end
end