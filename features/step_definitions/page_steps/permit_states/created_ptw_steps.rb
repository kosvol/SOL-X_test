# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/created_ptw_page'

And('CreatedPTW click first permit') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @created_ptw_page.click_first_permit
end

And('CreatedPTW click button Delete') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @created_ptw_page.delete_current_permit
end

Then('CreatedPTW verify deleted permit not presents in list') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @created_ptw_page.verify_deleted_permit
end
