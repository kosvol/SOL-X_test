# frozen_string_literal: true
require_relative '../../../../page_objects/permit_states/created_entry_page'
require_relative '../../../../page_objects/precre/create_entry_permit_page'

And('CreatedEntry click first permit') do
  @created_entry_page ||= CreatedEntryPage.new(@driver)
  @created_entry_page.click_first_permit
end

And('CreatedEntry click button Delete') do
  @created_entry_page ||= CreatedEntryPage.new(@driver)
  @created_entry_page.delete_current_permit
end

Then('CreatedEntry verify deleted permit not presents in list') do
  @created_entry_page ||= CreatedEntryPage.new(@driver)
  @create_entry_permit_page ||= CreatedEntryPage.new(@driver)
  p(@create_entry_permit_page.permit_id)
  @created_entry_page.verify_deleted_permit(@create_entry_permit_page.permit_id)
end
