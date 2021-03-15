
And (/^I add normal gas readings$/) do
  BrowserActions.wait_until_is_visible(on(NewEntrantPage).new_entry_bn_element)
  on(NewEntrantPage).new_entry_bn_element.click
  sleep 1
  on(EntryLog).add_normal_gas_readings
  BrowserActions.wait_until_is_visible(on(EntryLog).continue_btn_element)
  on(EntryLog).continue_btn_element.click
end

And (/^I review and sign gas readings$/) do
  BrowserActions.wait_until_is_visible(on(EntryLog).review_sign_btn_element)
  on(EntryLog).review_sign_btn_element.click
  BrowserActions.wait_until_is_visible(on(SignaturePage).signing_canvas_element)
  on(SignaturePage).sign_for_gas
  on(EntryLog).enter_pin_and_sbmt_element.click
end


And ('I select entrants {int}') do |_entrants_number|
   BrowserActions.wait_until_is_visible(on(NewEntryPage).input_field_element)
   on(NewEntryPage).entrant_select_btn_element.click
  on(NewEntryPage).select_entrants(_entrants_number)
  on(NewEntryPage).save_entrants(_entrants_number)
  on(NewEntryPage).confirm_btn_element.click
end

Then (/^I check the Send Report button is enabled$/) do
  if is_enabled(on(NewEntryPage).send_report_btn_elements.first)
    p 'Button is enabled'
  else
    raise 'Button is disabled'
  end
end

Then (/^I check the Send Report button is disabled$/) do
  if is_disabled(on(NewEntryPage).send_report_btn_elements.first)
    p 'Button is disabled'
  else
    raise 'Button is enabled'
  end
end

Then (/^I save names of entrants$/) do
  save_entrants()
end