# frozen_string_literal: true

require_relative '../../../../page_objects/entry/common_entry_page'

Given('CommonEntry click Add Gas Reader') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.click_add_gas_reader
end

Given('CommonEntry click request for update') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.click_updates_needed
end

Given('CommonEntry submit comment {string}') do |comment_text|
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.submit_comment(comment_text)
end

And('CommonEntry verify comment {string}') do |comment_text|
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.verify_comment(comment_text)
end

And('CommonEntry verify non approval authority view') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.verify_non_auth_view
end

And('CommonEntry save temp id') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @temp_id = @common_entry_page.retrieve_temp_id
end

And('CommonEntry check Responsible Officer Signature') do |table|
  params = table.hashes.first
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.check_ra_signature(params['rank'], params['zone'])
end

And('CommonEntry verify no add gas reading button') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.verify_no_add_gas_btn
  @common_entry_page.verify_non_auth_view
end

Given('CommonEntry click submit for approval') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.click_submit_approval
end

And('CommonEntry verify validation pop up') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.verify_validation
end

And('CommonEntry click approve for activation') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.click_approve_for_activation
end

Given('CommonEntry verify the request updates option') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.verify_comment_btn
end

And('CommonEntry verify add gas reading button') do
  @common_entry_page ||= CommonEntryPage.new(@driver)
  @common_entry_page.verify_add_gas_btn
end
