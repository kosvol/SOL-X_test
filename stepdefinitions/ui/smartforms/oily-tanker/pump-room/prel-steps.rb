And (/^I enter (new|same|without toxic) entry log$/) do |_condition|
  step 'I sleep for 10 seconds'
  on(PreDisplay).new_entry_log_element.click

  on(PumpRoomEntry).add_all_gas_readings_pre('1','2','3','4','Test','20','1.5','cc') if _condition === 'same'
  on(PumpRoomEntry).add_all_gas_readings_pre('2','3','4','5','Test','20','2','cc') if _condition === 'new'
  on(PumpRoomEntry).add_all_gas_readings_pre('2','3','4','5','','','','') if _condition === 'without toxic'
  step "I sign for gas"
  step 'I enter pin for rank A/M'
  step 'I sleep for 1 seconds'
end

Then (/^I should see correct signed in entrants$/) do
  on(PreDisplay).home_tab_element.click
  on(PreDisplay).sign_out_btn_elements.first.click
  sleep 2
  is_equal(on(PumpRoomEntry).signed_in_entrants_elements.first.text,"A/M Atif Hayat")
  is_equal(on(PumpRoomEntry).signed_in_entrants_elements.size,1)
end

Then (/^I should not see entered entrant on list$/) do
  on(PreDisplay).home_tab_element.click
  is_false(on(PumpRoomEntry).is_entered_entrant_listed?("MAS Daniel Alcantara"))
end

Then (/^I should not see entered entrant on optional entrant list$/) do
  is_true(on(PumpRoomEntry).is_entered_entrant_listed?("MAS Daniel Alcantara"))
end

# And ('I send entry report with {int} optional entrants') do |_optional_entrant|
#   on(PumpRoomEntry).additional_entrant(_optional_entrant) if _optional_entrant > 0
#   sleep 1
#   BrowserActions.js_click("//span[contains(text(),'Send Report')]")
# end
And (/^I (send|fill) entry report with (.*) (optional|required) entrants$/) do |_condition1, _optional_entrant, _condition|
  if (_condition === 'optional') && (_condition1 === 'send')
    on(PumpRoomEntry).additional_entrant(_optional_entrant.to_i) if _optional_entrant.to_i > 0
    sleep 1
    BrowserActions.js_click("//span[contains(text(),'Send Report')]")
  elsif (_condition === 'required') && (_condition1 === 'send')
    step "I select required entrants #{_optional_entrant.to_i}"
    sleep 1
    BrowserActions.js_click("//span[contains(text(),'Send Report')]")
  elsif (_condition === 'required') && (_condition1 === 'fill')
    on(PumpRoomEntry).input_field1_element.send_keys("Test Automation")
    step "I select required entrants #{_optional_entrant.to_i}"
  elsif (_condition === 'optional') && (_condition1 === 'fill')
    on(PumpRoomEntry).input_field1_element.send_keys("Test Automation")
    on(PumpRoomEntry).additional_entrant(_optional_entrant.to_i) if _optional_entrant.to_i > 0
  end
end

And ('I select required entrants {int}') do |_entrants_number|
  BrowserActions.wait_until_is_visible(on(PumpRoomEntry).input_field_element)
  on(PumpRoomEntry).entrant_select_btn_element.click
  on(PumpRoomEntry).required_entrants(_entrants_number)
  on(PumpRoomEntry).confirm_btn_elements.first.click
end


Then (/^I should see (entrant|required entrants) count equal (.*)$/) do |_condition,_count|
  if _condition === 'entrant'
    on(PreDisplay).home_tab_element.click
    step 'I sleep for 1 seconds'
    if _count === "0"
      not_to_exists(on(PreDisplay).entrant_count_element)
    else
      is_equal(on(PreDisplay).entrant_count_element.text,_count)
    end
  elsif _condition === 'required entrants'
    while _count.to_i.positive?
      is_enabled($browser
                   .find_element(:xpath,
                                 "//*[starts-with(@class,'UnorderedList')]/li[#{_count.to_s}]"))
      _count = _count.to_i - 1
      p 'enabled'
    end
  end
end

And (/^I acknowledge the new entry log via service$/) do
  step 'I sleep for 6 seconds'
  SmartFormDBPage.acknowledge_pre_entry_log
  step 'I sleep for 3 seconds'
end

Then (/^I (shoud not|should) see dashboard gas reading popup$/) do |_condition|
  step 'I acknowledge the new entry log via service'
  step 'I sleep for 1 seconds'
  if _condition === 'should not'
    is_equal(SmartFormDBPage.get_error_message,"No pending PRED record")
  elsif _condition === 'should'
    ServiceUtil.get_response_body['data']['acknowledgeUnsafeGasReading']
  end
end

And (/^I terminate from dashboard$/) do
    ## pending frontend implementation
end

And ("I signout {int} entrants") do |total_entrants|
end

Then (/^I check the Send Report button is (enabled|disabled)$/) do |_condition|
  case _condition
  when "enabled"
    is_enabled(on(PreDisplay).send_report_btn_elements.first)
  when "disabled"
    is_disabled(on(PreDisplay).send_report_btn_elements.first)
  else
    raise "wrong condition"
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