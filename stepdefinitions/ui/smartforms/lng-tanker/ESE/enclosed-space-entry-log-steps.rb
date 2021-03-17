And ('I select required entrants {int}') do |_entrants_number|
  BrowserActions.wait_until_is_visible(on(PumpRoomEntry).input_field_element)
   on(PumpRoomEntry).entrant_select_btn_element.click
   on(PumpRoomEntry).required_entrants(_entrants_number)
   on(PumpRoomEntry).confirm_btn_elements.first.click
end


Then (/^I check the Send Report button is enabled$/) do
  if is_enabled(on(PreDisplay).send_report_btn_elements.first)
    p 'Button is enabled'
  else
    raise 'Button is disabled'
  end
end

Then (/^I check the Send Report button is disabled$/) do
  p on(PreDisplay).send_report_btn_elements.first.text
   if is_disabled(on(PreDisplay).send_report_btn_elements.first)
     p 'Button is disabled'
  else
    raise 'Button is enabled'
  end
end

Then ('I check entrants in list {int}') do |item|
  while item.positive?
    is_enabled($browser
                 .find_element(:xpath, '//*[starts-with(@class,\'UnorderedList\')]/li[' + item.to_s + ']'))
    item = item - 1
    p 'enabled'
  end
end


Then ('I check names of entrants {int} on New Entry page') do |item|
  entr_arr = []
  while item.positive?
    entr_arr.push($browser
                    .find_element(:xpath, '//*[starts-with(@class,\'UnorderedList\')]/li[' + item.to_s + ']')
                    .attribute('aria-label'))
    item = item - 1
  end
  p "second"
  p entr_arr.to_s
  arr_before = on(PumpRoomEntry).get_entrants
  p arr_before
  expect(arr_before.to_a).to match_array entr_arr.to_a
end

And (/^I send Report$/) do
  BrowserActions.wait_until_is_visible(on(PreDisplay).send_report_element)
  on(PreDisplay).send_report_btn_elements.first.click
  on(PreDisplay).send_report_element.click
  BrowserActions.wait_until_is_visible(on(CommonFormsPage).done_btn_elements.first)
  on(CommonFormsPage).done_btn_elements.first.click
end

Then (/^I should not see empty form elements$/) do
  sleep 3
  on(PumpRoomEntry).entry_log_btn_element.click
  sleep 1
  is_disabled(on(PreDisplay).info_gas_testing_is_missing_elements[2])
  is_disabled(on(PreDisplay).info_gas_testing_is_missing_elements[3])
end

Then (/^I should see no new entry log message in Entry log$/) do
  sleep 3
  on(PumpRoomEntry).entry_log_btn_element.click
  sleep 1
  is_equal(on(PreDisplay)
             .info_gas_testing_is_missing_elements[2]
             .text,"No Entry Yet")
  is_equal(on(PreDisplay)
             .info_gas_testing_is_missing_elements[3]
             .text,"Press on “New Entry” button on the “Home” page to record a new entry.")
end