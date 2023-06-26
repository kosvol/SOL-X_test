# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/op_modal_window'

Given('OfficePortal verify pop-up window') do |table|
  @op_modal_window ||= OPModalWindow.new(@driver)
  @op_modal_window.verify_popup(table)
  @op_modal_window.verify_popup_button
end

Then('OfficePortal click {string} button in the pop-up window') do |button|
  @op_modal_window ||= OPModalWindow.new(@driver)
  @op_modal_window.pop_click_button(button)
end
