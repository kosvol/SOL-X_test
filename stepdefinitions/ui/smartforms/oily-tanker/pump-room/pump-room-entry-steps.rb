And(/^I navigate to create new (PRE|CRE)$/) do |permit_type|
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).create_new_pre_btn_element) if permit_type == 'PRE'
  BrowserActions.poll_exists_and_click(on(PumpRoomEntry).create_new_cre_btn_element) if permit_type == 'CRE'
  sleep 1
end

Then(/^I (should|should not) see PRE landing screen$/) do |condition|
  is_true(on(PumpRoomEntry).heading_text == 'Section 1: Pump Room Entry Permit') if condition == 'should'
end

Then(/^I should see the right order of elements$/) do
  base_data = YAML.load_file('data/pre/pump-room-entries.yml')['questions']
  on(PumpRoomEntry).form_structure_elements.each_with_index do |element, index|
    p "#{element.text}\","
    is_equal(element.text, base_data[index])
  end
end

Then(/^I (should|should not) see alert message "(.*)"$/) do |condition, alert|
  is_true(on(PumpRoomEntry).is_alert_text_displayed?(alert)) if condition == 'should'

  is_false(on(PumpRoomEntry).is_alert_text_displayed?(alert)) if condition == 'should not'
end

Then('I select Permit Duration {int}') do |duration|
  on(PumpRoomEntry).select_permit_duration(duration)
end

And(/^Button "([^"]*)" (should|should not) be disabled$/) do |button_text, condition|
  is_false(on(PumpRoomEntry).is_button_enabled?(button_text)) if condition == 'should'

  is_true(on(PumpRoomEntry).is_button_enabled?(button_text)) if condition == 'should not'
end

Then(/^I select current day for field "([^"]*)"$/) do |button|
  on(PumpRoomEntry).gas_last_calibration_button
  sleep 1
  on(PumpRoomEntry).current_day_button_btn
  sleep 1
  is_true(on(PumpRoomEntry).gas_last_calibration_button_element.text == Time.now.strftime('%d/%b/%Y'))
end

Then(%r{^I click (Yes|No|N/A) to answer the question "(.*)"$}) do |answer, question|
  on(PumpRoomEntry).select_answer(answer, question)
end

And(/^I (should|should not) see Reporting interval$/) do |condition|
  sleep 1
  BrowserActions.scroll_down
  if condition == 'should not'
    not_to_exists(on(PumpRoomEntry).reporting_interval_element)
  elsif condition == 'should'
    to_exists(on(PumpRoomEntry).reporting_interval_element)
  end
end

Then(/^I press the "([^"]*)" button$/) do |button|
  on(PumpRoomEntry).press_the_button(button)
end

And(/^I (should|should not) see the (text|label|page|header) '(.*)'$/) do |condition, like, text|
  sleep 1
  is_true(on(PumpRoomEntry).is_text_displayed?(like, text)) if condition == 'should'
  is_false(on(PumpRoomEntry).is_text_displayed?(like, text)) if condition == 'should not'
end

And(/^for (pre|cre) I should see the (disabled|enabled) "([^"]*)" button$/) do |_permit_type, condition, button|
  is_false(on(PumpRoomEntry).is_button_enabled?(button)) if condition == 'disabled'

  is_true(on(PumpRoomEntry).is_button_enabled?(button)) if condition == 'enabled'
end

And('I fill up {string}') do |section|
  on(PumpRoomEntry).fill_up_section(section)
end

# And(/^I should be able to delete the record$/) do
#   on(PumpRoomEntry).toxic_gas_del_row
#   is_equal(on(PumpRoomEntry).toxic_gas_rows, 0)
# end

Then(/^\(for pre\) I sign on canvas$/) do
  on(PumpRoomEntry).sign
end

Then(/^I (fill up|fill up with gas readings) (PRE.|CRE.) Duration (.*). Delay to activate (.*)$/) do |gas, permit_type, duration, delay|
  on(Section3APage).scroll_multiple_times_with_direction(1,'down')
  if gas == 'fill up with gas readings'
    on(Section6Page).add_all_gas_readings
    step 'I sign for gas'
    step 'I enter pin via service for rank C/O'
    step 'I dismiss gas reader dialog box'
  end
  on(Section3APage).scroll_multiple_times_with_direction(1, 'up')
  on(PumpRoomEntry).fill_up_pre(duration)
  on(Section3APage).scroll_multiple_times_with_direction(1,'down')
  on(PumpRoomEntry).select_start_time_to_activate(delay)
end

Then(/^I (fill up|change) (PRE|CRE) Duration (.*) Delay to activate (.*) with custom days (.*) in (Future|Past) from (selected|current)$/) do |condition, permit_type, duration, delay, days, direction, point|
  on(PumpRoomEntry).fill_up_pre(duration) if condition == 'fill up'
  on(Section3APage).scroll_multiple_times_with_direction(1,'down') if condition == 'fill up'
  on(PumpRoomEntry).select_day(direction, days, point)
  on(PumpRoomEntry).select_start_time_to_activate(delay) if condition == 'fill up'
end

And(/^for (pre|cre) I submit permit for (.*) Approval$/) do |permit_type, role|
  step 'Get PRE id'
  step 'I press the "Submit for Approval" button'
  step format('I enter pin for rank %s', role.to_s)
  sleep 3
  on(SignaturePage).sign_and_done
  step "I should see the page 'Successfully Submitted'"
  sleep 2
  step 'I press the "Back to Home" button'
end

And(/^I activate the current (PRE|CRE) form$/) do |permit_type|
  step "I open the current #{permit_type} with status Pending approval. Rank: C/O"
  step format('I take note of start and end validity time for %s', permit_type.to_s)
  step 'I press the "Approve for Activation" button'
  step 'I sign with valid C/O rank'
  step "I should see the page 'Permit Successfully Scheduled for Activation'"
  sleep 1
  step 'I press the "Back to Home" button'
end

And(/^I activate (PRE|CRE) form via service$/) do |permit_type|
  sleep 1
  on(BypassPage).activate_pre_cre
  sleep 5
end

And(/^I take note of start and end validity time for (.*)$/) do |permit_type|
  on(PumpRoomEntry).get_validity_start_and_end_time(permit_type.to_s)
end

And(/^I (should|should not) see the current (PRE|CRE) in the "([^"]*)" list$/) do |condition, _permit_type, _list|
  Log.instance.info("form id >> #{@@pre_number}")
  step "I #{condition} see the text '#{@@pre_number}'"
end

And(/^I should see that existed (PRE|CRE) number not equal with number Active list$/) do |permit|
  Log.instance.info("Form id existed: >> #{@@pre_number}")
  Log.instance.info("Form id in list: >> #{on(Section0Page).ptw_id_element.text}")
  on(Section0Page).ptw_id_element.text != @@pre_number
end

And('I set the activity end time in {int} minutes') do |minutes|
  status = on(PumpRoomEntry).reduce_time_activity(minutes)
  is_equal(status['ok'], 'true')
end

Then(/^I should see current PRE is auto terminated$/) do
  is_true(on(PumpRoomEntry).is_auto_terminated_displayed?(@@pre_number))
end

Then(/^I terminate the (PRE|CRE)$/) do |type|
  step "I navigate to \"Active\" screen for #{type}"
  on(PumpRoomEntry).press_button_for_current_PRE('Submit for Termination')
  step 'I enter pin for rank C/O'
  step 'I press the "Terminate" button'
  step 'I sign with valid C/O rank'
  step "I should see the text 'Permit Has Been Closed'"
  sleep 1
  step 'I press the "Back to Home" button'
end

Then(/^I terminate the (PRE|CRE) with rank ([^"]*)$/) do |type, rank|
  step "I navigate to \"Active\" screen for #{type}"
  on(PumpRoomEntry).press_button_for_current_PRE('Submit for Termination')
  step "I enter pin for rank #{rank}"
  step 'I press the "Terminate" button'
  step "I sign with valid #{rank} rank"
  step "I should see the text 'Permit Has Been Closed'"
  sleep 1
  step 'I press the "Back to Home" button'
end

Then(/^I request update needed$/) do
  step 'I open the current PRE with status Pending approval. Rank: A C/O'
  step 'I request update for permit'
  step "I should see the text 'Your Updates Have Been Successfully Requested'"
  sleep 1
  step 'I press the "Back to Home" button'
end

And('(for pre) I should see update needed message') do
  step 'I navigate to "Updates Needed" screen for PRE'
  on(PumpRoomEntry).press_button_for_current_PRE('Edit/Update')
  step 'I enter pin for rank C/O'
  step "I should see the text 'Comments from Approving Authority'"
  step "I should see the text 'Test Automation'"
end

And(/^I should see that form is open for read by rank (.*)$/) do |rank|
  step 'I navigate to "Updates Needed" screen for PRE'
  on(PumpRoomEntry).press_button_for_current_PRE('Edit/Update')
  step format('I enter pin via service for rank %s', rank)
  step 'Button "Submit for Approval" should be disabled'
  step 'Button "Add Gas Test Record" should be disabled'

end

And(/^Get (PRE|CRE|PWT) id$/) do |permit_type|
  @temp_id = on(Section0Page).ptw_id_element.text
  @@pre_number = on(Section0Page).ptw_id_element.text
  @@issue_time = on(PreDisplay).pre_duration_timer_element.text if permit_type === 'PWT'
end

Then(/^I open the current (PRE|CRE) with status (Pending approval|Active). Rank: (.*)$/) do |permit_type, condition, rank|
  step "I navigate to \"Pending Approval\" screen for #{permit_type}" if condition == 'Pending approval'
  step "I navigate to \"Active\" screen for #{permit_type}" if condition == 'Active'
  on(PumpRoomEntry).press_button_for_current_PRE('Officer Approval') if condition == 'Pending approval'
  on(PumpRoomEntry).view_btn_element.click if condition == 'Active'
  step format('I enter pin via service for rank %s', rank)
  sleep 1
end

Then(/^\(table\) Buttons should be missing for the following role:$/) do |roles|
  # table is a table.hashes.keys # => [:Chief Officer, :8383]
  roles.raw.each do |role|
    step format('I open the current PRE with status Pending approval. Rank: %s', role[0].to_s)
    on(CommonFormsPage).scroll_multiple_times_with_direction(20,'down')
    not_to_exists(on(PumpRoomEntry).approve_activation_element)
    not_to_exists(on(Section7Page).update_btn_element)
    is_equal(on(CommonFormsPage).close_btn_elements.size, 1)
    step 'I click on back arrow'
  end
end

Then(/^I check scheduled date$/) do
  on(PumpRoomEntry).compare_scheduled_date
end

And(/^I get a temporary number and writing it down$/) do
  @temp_id = on(Section0Page).ptw_id_element.text
  is_equal(@temp_id.include?('TEMP'), true)
  on(PumpRoomEntry).purpose_of_entry = 'Test Automation'
  step 'I press the "Save" button'
  sleep 1
  step 'I press the "Close" button'
  sleep 1
end

Then(/^I getting a permanent number from indexedDB$/) do
  p(@temp_id)
  @@pre_number = WorkWithIndexeddb.get_id_from_indexeddb(@temp_id)
  CommonPage.set_permit_id(@@pre_number)
  # is_equal(@@pre_number.include?("PRE"), true)
end

Then(/^I edit pre and should see the old number previously written down$/) do
  on(PumpRoomEntry).press_button_for_current_PRE('Edit')
  step 'I enter pin for rank C/O'
  sleep 1
  is_equal(on(PumpRoomEntry).purpose_of_entry, 'Test Automation')
end

And(/^I signout the entrant$/) do
  on(PumpRoomEntry).home_tab_element.click
  on(PumpRoomEntry).signout_entrant(1)
end

Then(/^I should see exit timestamp updated$/) do
  on(PumpRoomEntry).entry_log_btn_element.click
  sleep 1
  does_include(on(PumpRoomEntry).entry_log_table_elements[3].text, on(CommonFormsPage).get_current_time)
end

And(/^I should see PRE display timezone$/) do
  on(PumpRoomEntry).home_tab_element.click
  step 'I sleep for 1 seconds'
  if on(CommonFormsPage).get_current_time_offset.to_i.abs <= 1
    is_equal(on(PreDisplay).time_shifted_by_text_element.text,
             "Local time adjusted by #{on(CommonFormsPage).get_current_time_offset} hour")
  else
    is_equal(on(PreDisplay).time_shifted_by_text_element.text,
             "Local time adjusted by #{on(CommonFormsPage).get_current_time_offset} hours")
  end
end

Then(/^I should see entry log details display as (filled|filled api)$/) do |condition|
  is_equal(on(PumpRoomEntry).entry_log_table_elements.first.text, "A/M #{EnvironmentSelector.get_vessel_type} A/M")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[1].text, 'Test Automation')
  case condition
  when 'filled'
    does_include(on(PumpRoomEntry).entry_log_table_elements[2].text,
                 on(PumpRoomEntry).get_entry_log_validity_start_details)
    does_include(on(PumpRoomEntry).entry_log_table_elements[2].text,
                 on(PumpRoomEntry).get_entry_log_validity_end_details)
  when 'filled api'
    p (@@issued_date_and_time[12, 5]).to_s
    p (@@issue_time[12, 5]).to_s
    does_include(on(PumpRoomEntry).entry_log_table_elements[2].text, (@@issued_date_and_time[12, 5]).to_s)
    does_include(on(PumpRoomEntry).entry_log_table_elements[2].text, (@@issue_time[12, 5]).to_s)
  end
  is_equal(on(PumpRoomEntry).entry_log_table_elements[4].text, on(CommonFormsPage).get_current_time_offset.to_s)
  is_equal(on(PumpRoomEntry).entry_log_table_elements[5].text, '2 %')
  is_equal(on(PumpRoomEntry).entry_log_table_elements[6].text, '3 % LEL')
  is_equal(on(PumpRoomEntry).entry_log_table_elements[7].text, '4 PPM')
  is_equal(on(PumpRoomEntry).entry_log_table_elements[8].text, '5 PPM')
  is_equal(on(PumpRoomEntry).entry_log_table_elements[9].text, '2 CC')
  is_equal(on(PumpRoomEntry).entry_log_table_elements[10].text, "C/O #{EnvironmentSelector.get_vessel_type} C/O")

end

Then('I should see timer countdown') do
  on(PumpRoomEntry).home_tab_element.click
  step 'I sleep for 3 seconds'
  p on(PreDisplay).pre_duration_timer_element.text.to_s
  if on(PreDisplay).pre_duration_timer_element.text.include? '03:58:'
    does_include(on(PreDisplay).pre_duration_timer_element.text, '03:58:')
  elsif on(PreDisplay).pre_duration_timer_element.text.include? '03:57:'
    does_include(on(PreDisplay).pre_duration_timer_element.text, '03:57:')
  elsif on(PreDisplay).pre_duration_timer_element.text.include? '03:56:'
    does_include(on(PreDisplay).pre_duration_timer_element.text, '03:56:')
  end
end

Then(/^I check all header-cells in Entry log table on (PWT|Dashboard)$/) do |condition|
  is_equal(on(PumpRoomEntry).header_cell_elements.first.text, 'Entrant')
  is_equal(on(PumpRoomEntry).header_cell_elements[1].text, 'Purpose')
  is_equal(on(PumpRoomEntry).header_cell_elements[2].text, 'Validity')
  is_equal(on(PumpRoomEntry).header_cell_elements[3].text, 'Time In/Out')
  is_equal(on(PumpRoomEntry).header_cell_elements[4].text, 'GMT')
  is_equal(on(PumpRoomEntry).header_cell_elements[5].text, 'O2')
  is_equal(on(PumpRoomEntry).header_cell_elements[6].text, 'HC')
  is_equal(on(PumpRoomEntry).header_cell_elements[7].text, 'H2S')
  is_equal(on(PumpRoomEntry).header_cell_elements[8].text, 'CO')
  is_equal(on(PumpRoomEntry).header_cell_elements[9].text, 'Test')
  case condition
  when 'dashboard'
    is_equal(on(PumpRoomEntry).header_cell_elements[10].text, 'Other Toxic')
    is_equal(on(PumpRoomEntry).header_cell_elements[11].text, 'Benzene')
    is_equal(on(PumpRoomEntry).header_cell_elements[12].text, 'NO2')
  when 'PTW'
    # shoud be "Competent Person"
    is_equal(on(PumpRoomEntry).header_cell_elements[10].text, 'OOW')
  end
end

Then(/^I check toxic gas readings on (last|previous) PTW Entry log (table|dashboard)$/) do |type, condition|
  case condition
  when 'table'
    if type == 'last'
      is_equal(on(PumpRoomEntry).header_cell_elements[9].text, 'Test')
      is_equal(on(PumpRoomEntry).entry_log_table_elements[9].text, '2 CC')
    elsif type == 'previous'
      is_not_equal($browser
        .find_elements(:xpath, "//div[starts-with(@class,'header-column')][1]/div")[9].text, 'Test')
      is_not_equal($browser
        .find_elements(:xpath, "//div[@data-testid='entry-log-column'][1]/div")[9].text, '2 CC')
    end
  when 'dashboard'
    is_equal(on(PumpRoomEntry).header_pwt_elements.first.text, @@pre_number)
    is_equal(on(PumpRoomEntry).header_cell_elements[9].text, 'Test')
    is_equal(on(PumpRoomEntry).entry_log_table_elements[9].text, '2 CC')

    is_not_equal(on(PumpRoomEntry).header_pwt_elements[1].text, @@pre_number)
    i = 0
    while i < 5
      is_not_equal($browser
        .find_elements(:xpath, "//div[starts-with(@class,'header-column')][1]/div")[i].text, 'Test')
      puts($browser.find_elements(:xpath, "//div[starts-with(@class,'header-column')][1]/div")[i].text)
      is_not_equal($browser
        .find_elements(:xpath, "//div[@data-testid='entry-log-column'][1]/div")[i].text, '2 CC')
      i += 1
    end
  else
    raise 'Wrong condition'
  end
end

Then(/^I check initial gas readings is (exist|not exist)$/) do |condition|
  case condition
  when 'exist'
    to_exists(on(PumpRoomEntry).gas_O2_element)
    to_exists(on(PumpRoomEntry).gas_HC_element)
    to_exists(on(PumpRoomEntry).gas_H2S_element)
  when 'not exist'
    not_to_exists(on(PumpRoomEntry).gas_O2_element)
    not_to_exists(on(PumpRoomEntry).gas_HC_element)
    not_to_exists(on(PumpRoomEntry).gas_H2S_element)
  else
    raise 'Wrong condition'
  end
end

Then(/^I check report not send$/) do
  to_exists(on(PreDisplay).send_report_element)
  not_to_exists(on(PreDisplay).entry_log_btn_element)
  not_to_exists(on(PreDisplay).home_tab_element)
  not_to_exists(on(PreDisplay).permit_tab_element)
end
