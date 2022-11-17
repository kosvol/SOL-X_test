# frozen_string_literal: true

require_relative '../../../page_objects/pin_entry_page'

Given('PinEntry enter pin for rank {string}') do |rank|
  @pin_entry_page ||= PinEntryPage.new(@driver)
  @pin_entry_page.enter_pin(rank)
end

Then('PinEntry should see error msg {string}') do |error_msg|
  @pin_entry_page.verify_error_msg(error_msg)
end

Given('PinEntry verify the error message is correct for the wrong rank') do |table|
  @pin_entry_page ||= PinEntryPage.new(@driver)
  @pin_entry_page.enter_pins(table)
end
