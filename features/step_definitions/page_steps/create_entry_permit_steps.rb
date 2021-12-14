# frozen_string_literal: true
require_relative '../../../page_objects/precre/create_entry_permit_page'

#I take note of start and end validity time for (.*)
And('CreateEntryPermit save current start and end validity time for {string}') do |permit_type|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.retrieve_start_end_time(permit_type)
end

#And(/^Get (PRE|CRE|PWT) id$/) do |permit_type|
And('CreateEntryPermit save permit id') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.save_permit_id
end

#Then(/^I press the "([^"]*)" button$/) do |button|
Then('CreateEntryPermit click Submit for Approval button') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.click_submit_for_approval
end

And('CreateEntryPermit select next date') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.select_next_date
end

And('CreateEntryPermit save form time') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.save_time
end

And('CreateEntryPermit verify popup dialog with {string} crew member') do |rank_name|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_crew_in_popup(rank_name)
end

#And(/^I (should|should not) see the (text|label|page|header) '(.*)'$/) do |condition, like, text|
And('CreateEntryPermit verify page with text {string}') do |text|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_page_text(text)
end

And('CreateEntryPermit verify element with text {string}') do |text|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_element_text(text)
end

And('CreateEntryPermit verify alert text {string}') do |text|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_alert_text(text)
end

And('CreateEntryPermit verify header text {string}') do |text|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_header(text)
end

And('CreateEntryPermit verify button text {string}') do |text|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_button(text)
end

And('CreateEntryPermit verify label {string}') do |text|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_label(text)
end

Then('CreateEntryPermit click Back to Home button') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.click_back_to_home
end

#And(/^I (should|should not) see Reporting interval$/) do |condition|
And('CreateEntryPermit {string} see Reporting interval') do |option|
  @create_entry_permit_page.verify_reporting_interval(option)
end

#I (should|should not) see the current (PRE|CRE) in the "([^"]*)" list
And('CreateEntryPermit verify current permit presents in the list') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_element_and_text('text', @create_entry_permit_page.permit_id)
end
