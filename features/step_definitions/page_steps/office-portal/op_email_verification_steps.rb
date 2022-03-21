# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/op_email_verification_page'

Then('EmailVerification page should be displayed') do
  @op_email_verification ||= OPEmailVerificationPage.new(@driver)
  @op_email_verification.verify_page_header
end

Then('EmailVerification should see all the page attributes') do
  @op_email_verification ||= OPEmailVerificationPage.new(@driver)
  @op_email_verification.verify_verification_page_attr
end

And('EmailVerification click Cancel') do
  @op_email_verification ||= OPEmailVerificationPage.new(@driver)
  @op_email_verification.click_cancel
end

And('EmailVerification click Send verification code') do
  @op_email_verification ||= OPEmailVerificationPage.new(@driver)
  @op_email_verification.click_send_code
end

Then('EmailVerification should see the error message below the heading') do |table|
  @op_email_verification.verify_error_message(table)
end

When('EmailVerification enter email {string}') do |email|
  @op_email_verification ||= OPEmailVerificationPage.new(@driver)
  @op_email_verification.enter_email(email)
end

Then('EmailVerification should see the email {string} entered') do |email|
  @op_email_verification.verify_email_entered(email)
end

And('EmailVerification should see new elements') do
  @op_email_verification.verify_additional_elements
end

And('EmailVerification wait until the {string} field exists') do |field|
  @op_email_verification.verify_field_exists(field)
end

And('EmailVerification enter verification code {string}') do |code|
  @op_email_verification.enter_verification_code(code)
end

And('EmailVerification click Verify code') do
  @op_email_verification.click_verify_code
end

And('EmailVerification remove the last character from the Email') do
  @op_email_verification.remove_email_character
end
