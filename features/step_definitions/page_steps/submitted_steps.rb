# frozen_string_literal: true

require_relative '../../../page_objects/submitted_page'

Then('Submitted verify the form is Successfully Submitted') do
  @submitted_page ||= SubmittedPage.new(@driver)
  @submitted_page.verify_header_text
  @submitted_page.click_home_button
end
