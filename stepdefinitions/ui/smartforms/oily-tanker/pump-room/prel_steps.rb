# frozen_string_literal: true

And(/^I (enter|enter without sign) (new|same|without toxic|different|random) entry log$/) do |condition,
  gas_reading_value|
  if condition == 'enter'
    BrowserActions.wait_until_is_visible(on(PreDisplay).new_entry_log_element)
    BrowserActions.poll_exists_and_click(on(PreDisplay).new_entry_log_element)
    step 'I enter pin via service for rank A/M'
  end
  BrowserActions.wait_until_is_displayed(on(PumpRoomEntry).gas_O2_element)

  case gas_reading_value
  when 'same'
    on(PumpRoomEntry).add_all_gas_readings_pre('1', '2', '3', '4', 'Test', '20', '1.5', 'cc')
  when 'new'
    on(PumpRoomEntry).add_all_gas_readings_pre('2', '3', '4', '5', 'Test', '20', '2', 'cc')
  when 'without toxic'
    on(PumpRoomEntry).add_all_gas_readings_pre('2', '3', '4', '5', '', '', '', '')
  else
    on(PumpRoomEntry)
      .add_all_gas_readings_pre(rand(1..10).to_s,
                                rand(1..10).to_s, rand(1..10).to_s, rand(1..10).to_s, 'Test', '20', '2', 'cc')
  end
  step 'I sign for gas' if condition == 'enter'
end

And(/^I (enter|enter without sign) (new|same|without toxic|different|random) entry log with role ([^"]*)$/) do |condition,
  gas_reading_value, role|
  if condition == 'enter'
    BrowserActions.wait_until_is_visible(on(PreDisplay).home_tab_element)
    BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
    BrowserActions.poll_exists_and_click(on(PreDisplay).new_entry_log_element)
    step "I enter pin via service for rank #{role}"
  end
  BrowserActions.wait_until_is_displayed(on(PumpRoomEntry).gas_O2_element)

  case gas_reading_value
  when 'same'
    on(PumpRoomEntry).add_all_gas_readings_pre('1', '2', '3', '4', 'Test', '20', '1.5', 'cc')
  when 'new'
    on(PumpRoomEntry).add_all_gas_readings_pre('2', '3', '4', '5', 'Test', '20', '2', 'cc')
  when 'without toxic'
    on(PumpRoomEntry).add_all_gas_readings_pre('2', '3', '4', '5', '', '', '', '')
  else
    on(PumpRoomEntry)
      .add_all_gas_readings_pre(rand(1..10).to_s, rand(1..10).to_s,
                                rand(1..10).to_s, rand(1..10).to_s, 'Test', '20', '2', 'cc')
  end
  step 'I sign for gas' if condition == 'enter'
end

Then(/^I click on new entry log button$/) do
  BrowserActions.wait_until_is_visible(on(PreDisplay).new_entry_log_element)
  BrowserActions.wait_until_is_displayed(on(PreDisplay).new_entry_log_element)
  BrowserActions.poll_exists_and_click(on(PreDisplay).new_entry_log_element)
end

Then(/^I should see correct signed in entrants$/) do
  BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
  BrowserActions.poll_exists_and_click(on(PreDisplay).sign_out_btn_elements.first)
  sleep 2
  is_equal(on(PumpRoomEntry).signed_in_entrants_elements.first.text, 'A/M COT A/M')
  is_equal(on(PumpRoomEntry).signed_in_entrants_elements.size, 1)
end

Then(/^I should not see entered entrant on list$/) do
  BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
  is_false(on(PumpRoomEntry).is_entered_entrant_listed?('MAS COT MAS'))
end

Then(/^I should not see entered entrant on (optional|required) entrant list$/) do |condition|
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_names_dd_element) if condition == 'optional'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_select_btn_element) if condition == 'required'
  sleep 1
  arr_before = on(PumpRoomEntry).get_entrants
  on(PumpRoomEntry).options_text_elements.each do |item|
    expect(arr_before).not_to include(item.text)
  end
end

And(/^I (send|fill) entry report with (.*) (optional|required) entrants$/) do |condition1, optional_entrant, condition|
  if (condition == 'optional') && (condition1 == 'send')
    on(PumpRoomEntry).additional_entrant(optional_entrant.to_i) if optional_entrant.to_i.positive?
    sleep 1
    on(PreDisplay).send_report_element.click
  elsif (condition == 'required') && (condition1 == 'send')
    step "I select required entrants #{optional_entrant.to_i}"
    sleep 1
    on(PreDisplay).send_report_element.click
  elsif (condition == 'required') && (condition1 == 'fill')
    step "I select required entrants #{optional_entrant.to_i}"
  elsif (condition == 'optional') && (condition1 == 'fill')
    on(PumpRoomEntry).additional_entrant(optional_entrant.to_i) if optional_entrant.to_i.positive?
  end
end

And('I select required entrants {int}') do |entrants_number|
  BrowserActions.wait_until_is_visible(on(PumpRoomEntry).input_field_element)
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_select_btn_element)
  on(PumpRoomEntry).required_entrants(entrants_number)
  puts(on(PumpRoomEntry).confirm_btn_elements.size)
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).confirm_btn_elements.first)
end

Then(/^I should see (entrant|required entrants) count equal (.*)$/) do |condition, count|
  case condition
  when 'entrant'
    BrowserActions.poll_exists_and_click(on(PreDisplay).home_tab_element)
    step 'I sleep for 1 seconds'
    if count == '0'
      not_to_exists(on(PreDisplay).entrant_count_element)
    else
      is_equal(on(PreDisplay).entrant_count_element.text, count)
    end
  when 'required entrants'
    while count.to_i.positive?
      is_enabled(on(PreDisplay).ret_required_entrants(count))
      count = count.to_i - 1
      p 'enabled'
    end
  else
    raise "Wrong condition>>> #{condition}"
  end
end

And(/^I acknowledge the new entry log via service$/) do
  step 'I sleep for 6 seconds'
  SmartFormDBPage.acknowledge_pre_entry_log(CommonPage.get_permit_id)
  step 'I sleep for 3 seconds'
end

And(/^I acknowledge the new entry log (cre|pre) via service$/) do |_condition|
  step 'I sleep for 6 seconds'
  SmartFormDBPage.acknowledge_pre_entry_log(CommonPage.get_permit_id)
  step 'I sleep for 3 seconds'
end

Then(/^I (should not|should) see dashboard gas reading popup$/) do |condition|
  step 'I acknowledge the new entry log via service'
  if condition == 'should not'
    is_equal(SmartFormDBPage.get_error_message, 'No pending PRED record')
  else
    ServiceUtil.get_response_body['data']['acknowledgeUnsafeGasReading']
  end
end

And(/^I signout "([^"]*)" entrants by rank$/) do |arr_entry|
  on(PumpRoomEntry).signout_entrant_by_name(arr_entry)
end

And(/^I click signout button$/) do
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).sign_out_btn_elements.first)
end

Then(/^I check the Send Report button is (enabled|disabled)$/) do |condition|
  case condition
  when 'enabled'
    is_enabled(on(PreDisplay).send_report_btn_elements.first)
  when 'disabled'
    is_disabled(on(PreDisplay).send_report_btn_elements.first)
  else
    raise 'wrong condition'
  end
end

Then('I check names of entrants {int} on New Entry page') do |item|
  entr_arr = []
  while item.positive?
    entr_arr.push(on(PreDisplay).ret_required_entrants(item).attribute('aria-label'))
    item -= 1
  end
  p entr_arr.to_s
  arr_before = on(PumpRoomEntry).get_entrants
  p arr_before
  expect(arr_before.to_a).to match_array entr_arr.to_a
end

Then(/^I check that entrants "([^"]*)" not present in list$/) do |arr_entrants|
  sleep 1
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).sign_out_btn_elements.first)
  arr_entrants.split(',').each do |i|
    raise("Entrant #{i} is exists in list") unless on(PreDisplay).check_entrant_name(i)
  end
end

And(/^I (send|just send) Report$/) do |condition|
  case condition
  when 'send'
    BrowserActions.wait_until_is_visible(on(PreDisplay).send_report_element)
    on(PreDisplay).send_report_btn_elements.first.click
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

And(/^I (save|check) permit date on Dashboard LOG$/) do |action|
  case action
  when 'save'
    current = DateTime.now.strftime('%Y-%m-%d')
    on(DashboardPage).set_arr_data(current)
  when 'check'
    data = on(DashboardPage).get_arr_data
    unless is_equal(DateTime.parse(on(DashboardPage).entry_log_title_element.text), DateTime.parse(data[0]))
      raise 'date time verification fail'
    end
  else
    raise 'wrong action'
  end
end

And(/^I check number (.*) of entrants on dashboard$/) do |number|
  BrowserActions.wait_until_is_visible(on(DashboardPage).active_entrant_element)
  expect(on(DashboardPage).active_entrant_element.text).to include(number.to_s)
end

And(/^I open new dashboard page$/) do
  BrowserActions.open_new_page
  step 'I launch sol-x portal dashboard'
  sleep(10)
end

And(/^I switch to (first|last) tab in browser$/) do |condition|
  BrowserActions.switch_browser_tab(condition)
end

And(/^I check the entrants "([^"]*)" are (presents|not presents) in dashboard log$/) do |entrants, condition|
  BrowserActions.wait_until_is_visible(on(Section6Page).gas_reading_table_elements[0])
  arr_elements_text = []
  on(Section6Page).gas_reading_table_elements.each { |element| arr_elements_text.push(element.text) }
  case condition
  when 'presents'
    entrants.split(',').each { |x| does_include(arr_elements_text, x.to_s) }
  when 'not presents'
    entrants.split(',').each { |x| does_not_include(arr_elements_text, x.to_s) }
  else
    raise 'Wrong condition'
  end
end

Then(/^I check (CRE|PRE) elements on dashboard (active|inactive)$/) do |type, condition|
  sleep 5
  BrowserActions.wait_until_is_visible(on(DashboardPage).pre_cre_title_indicator_element)
  is_equal(on(DashboardPage).pre_cre_title_indicator_element.text, 'Pump Room Entry Permit:') if type == 'PRE'
  if type == 'CRE'
    is_equal(on(DashboardPage)
               .pre_cre_title_indicator_element.text, 'Compressor/Motor Room Entry Permit:')
  end
  is_equal(on(DashboardPage).pre_indicator_element.text, 'Active') if condition == 'active'
  is_equal(on(DashboardPage).pre_indicator_element.text, 'Inactive') if condition == 'inactive'
end

Then(/^I check the entrants "([^"]*)" are (presents|not presents) on New Entry page$/) do |entrants, condition|
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).entrant_select_btn_element)
  sleep 2
  list_of_ranks = on(BypassPage).get_rank_list_from_service
  arr_elements_text = []
  on(PumpRoomEntry).options_text_elements.each { |element| arr_elements_text.push(element.text) }
  case condition
  when 'presents'
    entrants.split(',').each { |x| does_include(arr_elements_text, "#{x} #{list_of_ranks[x]}") }
  when 'not presents'
    entrants.split(',').each { |x| does_not_include(arr_elements_text, "#{x} #{list_of_ranks[x]}") }
  else
    raise 'Wrong condition'
  end
end
