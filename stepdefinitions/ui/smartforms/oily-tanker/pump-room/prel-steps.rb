And (/^I (enter|enter without sign) (new|same|without toxic|different|random) entry log$/) do |_cond, _condition|
  # step 'I sleep for 10 seconds'
  BrowserActions.wait_until_is_visible(on(PreDisplay).new_entry_log_element)
  BrowserActions.poll_exists_and_click(on(PreDisplay).new_entry_log_element)

  on(PumpRoomEntry).add_all_gas_readings_pre('1', '2', '3', '4', 'Test', '20', '1.5', 'cc') if _condition === 'same'
  on(PumpRoomEntry).add_all_gas_readings_pre('2', '3', '4', '5', 'Test', '20', '2', 'cc') if _condition === 'new'
  on(PumpRoomEntry).add_all_gas_readings_pre('2', '3', '4', '5', '', '', '', '') if _condition === 'without toxic'
  on(PumpRoomEntry).add_all_gas_readings_pre('3', '4', '5', '5', 'Test', '20', '2', 'cc') if _condition === 'different'
  on(PumpRoomEntry).add_all_gas_readings_pre(rand(1..10).to_s, rand(1..10).to_s, rand(1..10).to_s, rand(1..10).to_s, 'Test', '20', '2', 'cc') if _condition === 'random'
  if _cond == 'enter'
    step 'I sign for gas'
    step 'I enter pin via service for rank A/M'
  end
  #  step 'I sleep for 1 seconds'
end

Then (/^I should see correct signed in entrants$/) do
  BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
  BrowserActions.poll_exists_and_click(on(PreDisplay).sign_out_btn_elements.first)
  sleep 2
  is_equal(on(PumpRoomEntry).signed_in_entrants_elements.first.text, 'A/M COT A/M')
  is_equal(on(PumpRoomEntry).signed_in_entrants_elements.size, 1)
end

Then (/^I should not see entered entrant on list$/) do
  BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
  is_false(on(PumpRoomEntry).is_entered_entrant_listed?('MAS COT MAS'))
end

Then (/^I should not see entered entrant on (optional|required) entrant list$/) do |condition|
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_names_dd_element) if condition === 'optional'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_select_btn_element) if condition === 'required'
  sleep 1
  arr_before = on(PumpRoomEntry).get_entrants
  on(PumpRoomEntry).options_text_elements.each do |item|
    expect(arr_before).not_to include(item.text)
  end
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
    step "I select required entrants #{_optional_entrant.to_i}"
  elsif (_condition === 'optional') && (_condition1 === 'fill')
    on(PumpRoomEntry).additional_entrant(_optional_entrant.to_i) if _optional_entrant.to_i > 0
  end
end

And ('I select required entrants {int}') do |_entrants_number|
  BrowserActions.wait_until_is_visible(on(PumpRoomEntry).input_field_element)
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_select_btn_element)
  on(PumpRoomEntry).required_entrants(_entrants_number)
  puts(on(PumpRoomEntry).confirm_btn_elements.size)
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).confirm_btn_elements.first)
end

Then (/^I should see (entrant|required entrants) count equal (.*)$/) do |_condition, _count|
  if _condition === 'entrant'
    BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
    step 'I sleep for 1 seconds'
    if _count === '0'
      not_to_exists(on(PreDisplay).entrant_count_element)
    else
      is_equal(on(PreDisplay).entrant_count_element.text, _count)
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
  SmartFormDBPage.acknowledge_pre_entry_log(CommonPage.get_permit_id)
  step 'I sleep for 3 seconds'
end

And (/^I acknowledge the new entry log (cre|pre) via service$/) do |_condition|
  step 'I sleep for 6 seconds'
  # @@pre_number = CommonPage.get_permit_id
  SmartFormDBPage.acknowledge_pre_entry_log(CommonPage.get_permit_id)
  step 'I sleep for 3 seconds'
end

Then (/^I (shoud not|should) see dashboard gas reading popup$/) do |_condition|
  step 'I acknowledge the new entry log via service'
  step 'I sleep for 1 seconds'
  if _condition === 'should not'
    is_equal(SmartFormDBPage.get_error_message, 'No pending PRED record')
  elsif _condition === 'should'
    ServiceUtil.get_response_body['data']['acknowledgeUnsafeGasReading']
  end
end

And (/^I terminate from dashboard$/) do
  ## pending frontend implementation
end

And (/^I signout "([^"]*)" entrants by rank$/) do |_arr_entry|
  on(PumpRoomEntry).signout_entrant_by_name(_arr_entry)
end

And (/^I click signout button$/) do
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).sign_out_btn_elements.first)
end

Then (/^I check the Send Report button is (enabled|disabled)$/) do |_condition|
  case _condition
  when 'enabled'
    is_enabled(on(PreDisplay).send_report_btn_elements.first)
  when 'disabled'
    is_disabled(on(PreDisplay).send_report_btn_elements.first)
  else
    raise 'wrong condition'
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
  p entr_arr.to_s
  arr_before = on(PumpRoomEntry).get_entrants
  p arr_before
  expect(arr_before.to_a).to match_array entr_arr.to_a
end

Then (/^I check that entrants "([^"]*)" not present in list$/) do |_arr_entrants|
  sleep 1
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).sign_out_btn_elements.first)
  _arr_entrants.split(',').each do |_i|
    if $browser.find_elements(:xpath, "//*[contains(.,'#{_i}')]").empty?
      puts("Entrant #{_i} not exists in list")
    else
      raise("Entrant #{_i} is exists in list")
    end
  end
end

And (/^I (send|just send) Report$/) do |_condition|
  case _condition
  when 'send'
    BrowserActions.wait_until_is_visible(on(PreDisplay).send_report_element)
    on(PreDisplay).send_report_btn_elements.first.click
    # on(PreDisplay).send_report_element.click
    step 'I sleep for 5 seconds'
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).done_btn_elements.first)
    on(CommonFormsPage).done_btn_elements.first.click
  when 'just send'
    BrowserActions.wait_until_is_visible(on(PreDisplay).send_report_element)
    on(PreDisplay).send_report_btn_elements.first.click
  else
    raise 'wrong action'
  end
end

And (/^I (save|check) permit date on Dashboard LOG$/) do |_action|
  if _action === 'save'
    current = DateTime.now.strftime('%Y-%m-%d')
    on(DashboardPage).set_arr_data(current)
  elsif _action === 'check'
    data = on(DashboardPage).get_arr_data
    puts(data[0].to_s)
    puts(DateTime.parse(on(DashboardPage).date_log_elements[0].text))
    puts(DateTime.parse(on(DashboardPage).date_log_elements[1].text))
    expect(DateTime.parse(on(DashboardPage).date_log_elements[1].text).to_s).to include(data[0].to_s)
    expect(DateTime.parse(on(DashboardPage).date_log_elements[0].text).to_s).not_to include(data[0].to_s)
  else
    raise 'wrong action'
  end
end

And (/^I check number (.*) of entrants on dashboard$/) do |_number|
  BrowserActions.wait_condition(20, on(DashboardPage).active_entarnt_element.text == _number.to_s)
  expect(on(DashboardPage).active_entarnt_element.text).to include(_number.to_s)
end

And (/^I open new dashboard page$/) do
  BrowserActions.open_new_page
  step 'I launch sol-x portal dashboard'
  sleep(10)
end

And (/^I switch to (first|last) tab in browser$/) do |_condition|
  BrowserActions.switch_browser_tab(_condition)
end

And (/^I check the entrants "([^"]*)" are (presents|not presents) in dashboard log$/) do |_entrants, _condition|
  BrowserActions.wait_until_is_visible(on(Section6Page).gas_reading_table_elements[0])
  elements = on(Section6Page).gas_reading_table_elements
  arr_elements_text = []
  elements.each { |element| arr_elements_text.push(element.text) }
  case _condition
  when 'presents'
    _entrants.split(',').each { |x| expect(arr_elements_text).to include(x.to_s) }
  when 'not presents'
    _entrants.split(',').each { |x| expect(arr_elements_text).not_to include(x.to_s) }
  else
    raise 'Wrong condition'
  end
end

Then(/^I check (CRE|PRE) elements on dashboard (active|inactive)$/) do |_type, _condition|
  sleep 5
  BrowserActions.wait_until_is_visible(on(DashboardPage).pre_cre_title_indicator_element)
  is_equal(on(DashboardPage).pre_cre_title_indicator_element.text, 'Pump Room Entry Permit:') if _type === 'PRE'
  is_equal(on(DashboardPage).pre_cre_title_indicator_element.text, 'Compressor/Motor Room Entry Permit:') if _type === 'CRE'
  is_equal(on(DashboardPage).pre_indicator_element.text, 'Active') if _condition === 'active'
  is_equal(on(DashboardPage).pre_indicator_element.text, 'Inactive') if _condition === 'inactive'
end

Then(/^I check the entrants "([^"]*)" are (presents|not presents) on New Entry page$/) do |_entrants, _condition|
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_select_btn_element)
  sleep 2
  list_of_ranks = on(BypassPage).get_rank_list_from_service
  list_of_ranks.each{|element| puts(element)}
  elements = on(PumpRoomEntry).options_text_elements
  arr_elements_text = []
  elements.each { |element| arr_elements_text.push(element.text)}
  case _condition
  when 'presents'
    _entrants.split(',').each { |x| expect(arr_elements_text).to include( x+" "+list_of_ranks[x])}
  when 'not presents'
    _entrants.split(',').each { |x| expect(arr_elements_text).not_to include( x+" "+list_of_ranks[x]) }
  else
    raise 'Wrong condition'
  end
end
