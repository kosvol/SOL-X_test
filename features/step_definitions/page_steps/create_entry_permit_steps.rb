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

#And(/^I (should|should not) see Reporting interval$/) do |condition|
And('PRE {string} see Reporting interval') do |option|
  @create_entry_permit_page.verify_reporting_interval(option)
end

And('CreateEntryPermit select next date') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.select_next_date
end
