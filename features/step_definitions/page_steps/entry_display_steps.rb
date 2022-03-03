# frozen_string_literal: true

require_relative '../../../page_objects/entry_display_page'

And('EntryDisplay wait for permit active') do
  @entry_display = EntryDisplay.new(@driver)
  @entry_display.wait_for_permit_active
end
