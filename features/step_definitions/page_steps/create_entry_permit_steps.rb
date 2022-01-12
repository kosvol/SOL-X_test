# frozen_string_literal: true

require_relative '../../../page_objects/precre/create_entry_permit_page'

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

Then('CreateEntryPermit click Back to Home button') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.click_back_to_home
end

#And(/^I (should|should not) see Reporting interval$/) do |condition|
And('CreateEntryPermit {string} see Reporting interval') do |option|
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_reporting_interval(option)
end

#I (should|should not) see the current (PRE|CRE) in the "([^"]*)" list
And('CreateEntryPermit verify current permit presents in the list') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_element_text(@create_entry_permit_page.permit_id)
end

Then('CreateEntryPermit click Officer Approval button') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.click_officer_approval_btn
end

Then('CreateEntryPermit set permanent permit number from IndexedDB') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.permit_from_indexed_db
end

Then('CreateEntryPermit verify permanent number presents in IndexedDB') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.verify_permit_in_indexed_db
end

And('CreateEntryPermit save permit id from list') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @create_entry_permit_page.save_ptw_id_from_list
end

And('CreateEntryPermit verify current permit presents in the list') do
  @create_entry_permit_page ||= CreateEntryPermitPage.new(@driver)
  @common_section_page.verify_permit
end

