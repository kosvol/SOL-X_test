# frozen_string_literal: true

require_relative '../../../../../page_objects/permit_states/entry/created_entry_page'

And('CreatedEntry verify temp permit is displayed') do
  @created_entry_page ||= CreatedEntryPage.new(@driver)
  @created_entry_page.verify_temp_permit(@temp_id)
end

And('CreatedEntry save first permit id') do
  @created_entry_page ||= CreatedEntryPage.new(@driver)
  @permit_id = @created_entry_page.save_first_permit_id
end

And('CreatedEntry click button Delete') do
  @created_entry_page ||= CreatedEntryPage.new(@driver)
  @created_entry_page.delete_first_permit
end

Then('CreatedEntry verify deleted permit not presents in list') do
  @created_entry_page.verify_deleted_permit(@permit_id)
end
