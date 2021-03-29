And(/^I navigate to create new (PRE|CRE)$/) do |_permit_type|
  on(PumpRoomEntry).create_new_pre_btn_element.click if _permit_type === "PRE"
  on(PumpRoomEntry).create_new_cre_btn_element.click if _permit_type === "CRE"
  sleep 1
end

Then (/^I (should|should not) see PRE landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).heading_text == "Section 1: Pump Room Entry Permit" )
  end
end

Then(/^I should see the right order of elements$/) do
  base_data = YAML.load_file("data/pre/pump-room-entries.yml")['questions']
  on(PumpRoomEntry).form_structure_elements.each_with_index do |_element,_index|
    p "#{_element.text}\","
    is_equal(_element.text,base_data[_index])
  end
end

Then(/^I (should|should not) see alert message "(.*)"$/) do |_condition, alert|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).is_alert_text_displayed?(alert))
  end

  if _condition === 'should not'
    is_false(on(PumpRoomEntry).is_alert_text_displayed?(alert))
  end
end

Then("I select Permit Duration {int}") do |duration|
  on(PumpRoomEntry).select_permit_duration(duration)
end

And(/^Button "([^"]*)" (should|should not) be disabled$/) do |button_text, _condition|
  if _condition === 'should'
    is_false(on(PumpRoomEntry).is_button_enabled?(button_text))
  end

  if _condition === 'should not'
    is_true(on(PumpRoomEntry).is_button_enabled?(button_text))
  end
end


Then(/^I select current day for field "([^"]*)"$/) do |button|
  on(PumpRoomEntry).gas_last_calibration_button
  sleep 1
  on(PumpRoomEntry).current_day_button_btn
  sleep 1
  is_true(on(PumpRoomEntry).gas_last_calibration_button_element.text == Time.now.strftime('%d/%b/%Y'))
end


Then(/^I click (Yes|No|N\/A) to answer the question "(.*)"$/) do |answer, question|
  on(PumpRoomEntry).select_answer(answer, question)
end

And(/^I (should|should not) see Reporting interval$/) do |_condition|
  sleep 1
  BrowserActions.scroll_down
  if _condition === 'should not'
    not_to_exists(on(PumpRoomEntry).reporting_interval_element)
  elsif _condition === 'should'
    to_exists(on(PumpRoomEntry).reporting_interval_element)
  end
end

Then(/^I press the "([^"]*)" button$/) do |button|
  on(PumpRoomEntry).press_the_button(button)
end

And (/^I should see the (text|label|page|header) '(.*)'$/) do |like, text|
  sleep 1
  is_true(on(PumpRoomEntry).is_text_displayed?(like,text))
end

And(/^for (pre|cre) I should see the (disabled|enabled) "([^"]*)" button$/) do |_permit_type,_condition, button|
    if _condition === 'disabled'
      is_false(on(PumpRoomEntry).is_button_enabled?(button))
    end

    if _condition === 'enabled'
      is_true(on(PumpRoomEntry).is_button_enabled?(button))
    end
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

Then(/^I fill up (PRE.|CRE.) Duration (.*). Delay to activate (.*)$/) do |_permit_type,_duration, delay|
  on(PumpRoomEntry).fill_up_pre(_duration)
  on(Section3APage).scroll_multiple_times(1)
  on(PumpRoomEntry).select_start_time_to_activate(delay)
end


And(/^for (pre|cre) I submit permit for (.*) Approval$/) do |_permit_type,_role|
  step 'Get PRE id'
  # @@pre_number = on(PumpRoomEntry).ptw_id_element.text
  # @temp_id = on(PumpRoomEntry).ptw_id_element.text
  step 'I press the "Submit for Approval" button'
  step "I enter pin for rank #{_role}"
  sleep 3
  on(SignaturePage).sign_and_done
  step "I should see the page 'Successfully Submitted'"
  sleep 2
  step 'I press the "Back to Home" button'
end

And(/^I activate the current (PRE|CRE) form$/) do |_permit_type|
  step 'I open the current PRE with status Pending approval. Rank: C/O'
  step 'I take note of start and end validity time'
  step 'I press the "Approve for Activation" button'
  step "I sign on canvas with valid 8383 pin"
  step "I should see the page 'Permit Successfully Scheduled for Activation'"
  sleep 1
  step 'I press the "Back to Home" button'
end

And ('I take note of start and end validity time') do
  on(PumpRoomEntry).get_validity_start_and_end_time
end

And(/^I should see the current (PRE|CRE) in the "([^"]*)" list$/) do |_permit_type,list|
  p "PRE ID: #{@@pre_number}"
  step "I should see the text '#{@@pre_number}'"
end

And('I set the activity end time in {int} minutes') do |minutes|
  status = on(PumpRoomEntry).reduce_time_activity(minutes)
  is_equal(status['ok'], 'true')
end

Then(/^I should see current PRE is auto terminated$/) do
  is_true(on(PumpRoomEntry).is_auto_terminated_displayed?(@@pre_number))
end

Then(/^I terminate the PRE$/) do
  step 'I navigate to "Active" screen for PRE'
  on(ActiveStatePage).terminate_permit_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(@@pre_number)].click
  # on(ActiveStatePage).get_termination_btn(@@pre_number).click
  # on(PumpRoomEntry).press_button_for_current_PRE("View/Termination")
  step 'I enter pin for rank C/O'
  step 'I press the "Terminate" button'
  step "I sign on canvas with valid 8383 pin"
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

And(/^\(for pre\) I should see update needed message$/) do
  step 'I navigate to "Updates Needed" screen for PRE'
  on(PumpRoomEntry).press_button_for_current_PRE("Edit/Update")
  step 'I enter pin for rank C/O'
  step "I should see the text 'Comments from Approving Authority'"
  step "I should see the text 'Test Automation'"
end


And(/^Get (PRE|CRE) id$/) do |_permit_type|
  @temp_id = on(PumpRoomEntry).ptw_id_element.text
  @@pre_number = on(PumpRoomEntry).ptw_id_element.text
  # step 'I set permit id'
end

Then(/^I open the current (PRE|CRE) with status Pending approval. Rank: (.*)$/) do |_permit_type,rank|
  step "I navigate to \"Pending Approval\" screen for #{_permit_type}"
  on(PumpRoomEntry).press_button_for_current_PRE("Officer Approval")
  step 'I enter pin for rank %s' %[rank]
  sleep 1
end

Then(/^\(table\) Buttons should be missing for the following role:$/) do |roles|
  # table is a table.hashes.keys # => [:Chief Officer, :8383]
   roles.raw.each do |role|
    step 'I open the current PRE with status Pending approval. Rank: %s' % [role[0].to_s]
    on(CommonFormsPage).scroll_multiple_times(20)
    not_to_exists(on(PumpRoomEntry).approve_activation_element)
    not_to_exists(on(Section7Page).update_btn_element)
    is_equal(on(CommonFormsPage).close_btn_elements.size,1)
    step 'I click on back arrow'
   end
end

And(/^I get a temporary number and writing it down$/) do
  @temp_id = on(PumpRoomEntry).ptw_id_element.text
  is_equal(@temp_id.include?("TEMP"), true)
  on(PumpRoomEntry).purpose_of_entry="Test Automation"
  step 'I press the "Save" button'
  sleep 1
  step 'I press the "Close" button'
  sleep 1
end

Then(/^I getting a permanent number from indexedDB$/) do
  @@pre_number =  WorkWithIndexeddb.get_id_from_indexeddb(@temp_id)
  # is_equal(@@pre_number.include?("PRE"), true)
end

Then(/^I edit pre and should see the old number previously written down$/) do
  on(PumpRoomEntry).press_button_for_current_PRE("Edit")
  step 'I enter pin for rank C/O'
  sleep 1
  is_equal(on(PumpRoomEntry).purpose_of_entry, "Test Automation")
end

And (/^I signout the entrant$/) do
  on(PumpRoomEntry).home_tab_element.click
  on(PumpRoomEntry).signout_entrant(1)
end

Then (/^I should see exit timestamp updated$/) do
  on(PumpRoomEntry).entry_log_btn_element.click
  sleep 1
  does_include(on(PumpRoomEntry).entry_log_table_elements[3].text,on(CommonFormsPage).get_current_time)
end

And (/^I should see PRE display timezone$/) do
  on(PumpRoomEntry).home_tab_element.click
  step 'I sleep for 1 seconds'
  if on(CommonFormsPage).get_current_time_offset.to_i <= 1
    is_equal(on(PreDisplay).time_shifted_by_text_element.text,"Local time adjusted by #{on(CommonFormsPage).get_current_time_offset} hour")
  else
    is_equal(on(PreDisplay).time_shifted_by_text_element.text,"Local time adjusted by #{on(CommonFormsPage).get_current_time_offset} hours")
  end
end

Then (/^I should see entry log details display as filled$/) do
  is_equal(on(PumpRoomEntry).entry_log_table_elements.first.text,"A/M Atif Hayat")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[1].text,"Test Automation")
  does_include(on(PumpRoomEntry).entry_log_table_elements[2].text,on(PumpRoomEntry).get_entry_log_validity_start_details)
  does_include(on(PumpRoomEntry).entry_log_table_elements[2].text,on(PumpRoomEntry).get_entry_log_validity_end_details)
  is_equal(on(PumpRoomEntry).entry_log_table_elements[4].text,"#{on(CommonFormsPage).get_current_time_offset}")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[5].text,"2 %")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[6].text,"3 % LEL")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[7].text,"4 PPM")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[8].text,"5 PPM")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[9].text,"2 CC")
  is_equal(on(PumpRoomEntry).entry_log_table_elements[10].text,"C/O Alister Leong")
end

Then ('I should see timer countdown') do
  on(PumpRoomEntry).home_tab_element.click
  step 'I sleep for 3 seconds'
  p "#{on(PreDisplay).pre_duration_timer_element.text}"
  if on(PreDisplay).pre_duration_timer_element.text.include? "03:58:"
    does_include(on(PreDisplay).pre_duration_timer_element.text,"03:58:")
  elsif on(PreDisplay).pre_duration_timer_element.text.include? "03:57:"
    does_include(on(PreDisplay).pre_duration_timer_element.text,"03:57:")
  end
end