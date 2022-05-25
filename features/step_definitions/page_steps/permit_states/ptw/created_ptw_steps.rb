# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/ptw/created_ptw_page'

And('CreatedPTW click first permit id') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @created_ptw_page.click_first_permit
end

And('CreatedPTW click edit') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @created_ptw_page.click_edit_btn(@permit_id)
end

And('CreatedPTW delete first permit id') do
  @created_ptw_page ||= CreatedPTWPage.new(@driver)
  @permit_id = @created_ptw_page.save_first_permit_id
  @created_ptw_page.delete_first_permit
end

And('CreatedPTW verify deleted permit') do
  @created_ptw_page.verify_permit_is_deleted(@permit_id)
end
