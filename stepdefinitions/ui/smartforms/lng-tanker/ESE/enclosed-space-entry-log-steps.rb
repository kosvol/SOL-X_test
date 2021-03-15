
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
   on(NewEntryPage).save_entrants_to_variable(_entrants_number)
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

Then ('I check entrants in list {int}') do |item|
  while item.positive?
    is_enabled($browser.find_element(:xpath, '//*[starts-with(@class,\'UnorderedList\')]/li[' + item.to_s + ']'))
    item = item - 1
    p 'enabled'
  end
end


Then ('I check names of entrants {int} on New Entry page') do |item|
  step 'I select entrants 3'
  entr_arr = []
  while item.positive?
    entr_arr.push($browser.
      find_element(:xpath, '//*[starts-with(@class,\'UnorderedList\')]/li[' + item.to_s + ']').attribute('aria-label'))
    item = item - 1
  end
  p "second"
  p entr_arr.to_s
  arr_before = on(NewEntryPage).get_entrants
  p arr_before
  expect(arr_before.to_a).to match_array entr_arr.to_a
end

And (/^I send Report$/) do
  BrowserActions.wait_until_is_visible(on(NewEntryPage).send_report_btn_elements.first)
  on(NewEntryPage).send_report_btn_elements.first.click
  BrowserActions.wait_until_is_visible(on(NewEntryPage).done_btn_element)
  on(NewEntryPage).done_btn_element.click
end

Then (/^I should not see empty form elements$/) do
  sleep 3
  on(NewEntrantPage).entry_log_btn_element.click
  sleep 1
  is_disabled(on(EntryLog).info_gas_testing_is_missing_elements[2])
  is_disabled(on(EntryLog).info_gas_testing_is_missing_elements[3])
end