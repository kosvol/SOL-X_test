And(/^I navigate to create new PRE$/) do
  on(PumpRoomEntry).create_new_pre_btn
  sleep 1
end

Then (/^I (should|should not) see PRE landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).ptw_id_element.text.include?('SIT/PRE/'))
  end
  if _condition === 'should not'

  end
end


Then(/^I should see all questions for PRE and three answers each$/) do |_table|
  is_true(on(PumpRoomEntry).are_questions?(_table.raw))
  is_true(on(PumpRoomEntry).has_three_types_answers?(_table.raw))
end

Then(/^I (should|should not) see alert message "(.*)"$/) do |_condition, alert|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).is_element_displayed?("xpath", alert, "alert_text"))
  end

  if _condition === 'should not'
    is_false(on(PumpRoomEntry).is_element_displayed?("xpath", alert, "alert_text"))
  end
end

Then(/^I select Permit Duration (.*)$/) do |duration|
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
  is_true(on(PumpRoomEntry).is_selected_date?(button))
end


Then(/^I click (Yes|No|N\/A) to answer the question "(.*)"$/) do |answer, question|
  on(PumpRoomEntry).select_answer(answer, question)
end

And(/^I (should|should not) see Reporting interval$/) do |_condition|
  id = "pre_section2_reportingIntervalPeriod"
  if _condition === 'should not'
    is_false(on(PumpRoomEntry).is_element_displayed?("id", id))
  end

  if _condition === 'should'
    is_true(on(PumpRoomEntry).is_element_displayed?("id", id))
  end
end

Then(/^I press the "([^"]*)" button$/) do |button|
  on(PumpRoomEntry).press_the_button(button)
end

And(/^I should see the page "([^"]*)"$/) do |section|
  is_true(on(PumpRoomEntry).is_element_displayed?("xpath", section, "text"))
end

And ('I should see the text {string}') do |text|
  is_true(on(PumpRoomEntry).is_element_displayed?("xpath", text, "text"))
end

And(/^\(for pre\) I should see the (disabled|enabled) "([^"]*)" button$/) do |_condition, button|
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

And(/^I should see a new row with filled data$/) do
  #is_true(on(PumpRoomEntry).how_many_rows == 1)
  is_equal(on(PumpRoomEntry).toxic_gas_rows_elements.size, 1.to_s)
end

And(/^I should be able to delete the record$/) do
  on(PumpRoomEntry).toxic_gas_del_row
  is_equal(on(PumpRoomEntry).toxic_gas_rows, 0)
end

Then(/^\(for pre\) I sign on canvas$/) do
  on(PumpRoomEntry).sign
end


And('I sign on Gas Test Record with {int} pin') do |_pin|
  on(PinPadPage).enter_pin(_pin)
  sleep 1
  step "I should see the text 'Gas Test Record Successfully Submitted'"
  sleep 1
  step 'I press the "Done" button'
  sleep 1
end

Then('I fill up PRE. Duration {int}. Delay to activate {int}') do |_duration, delay|
  on(PumpRoomEntry).fill_up_pre(_duration)
  on(PumpRoomEntry).select_start_time_to_activate(delay)
end


And(/^\(for pre\) I submit permit for Officer Approval$/) do
  @@pre_number = on(PumpRoomEntry).pre_id_element.text
  step 'I press the "Submit for Approval" button'
  step 'I enter pin 8383'
  step '(for pre) I sign on canvas'
  step 'I press the "Done" button'
  sleep 1
  step 'I should see the page "Successfully Submitted"'
  step 'I press the "Back to Home" button'
end

And('I activate the current PRE form') do
  step '(for per) I navigate to "Pending approval PRE" list'
  on(PumpRoomEntry).press_button_for_current_PRE("Officer Approval")
  step 'I enter pin 8383'
  sleep 1
  step 'I press the "Approve for Activation" button'
  sleep 1
  step 'I enter pin 8383'
  step '(for pre) I sign on canvas'
  step 'I press the "Done" button'
  step 'I press the "Back to Home" button'
  sleep 1
end

And(/^I should see the current PRE in the "([^"]*)" list$/) do |list|
  if list === "Scheduled"
    step '(for per) I navigate to "Scheduled" list'
    is_true(on(PumpRoomEntry).is_element_displayed?("xpath", @@pre_number, "text"))
    on(PumpRoomEntry).arrow_back_btn
  end

  if list === 'Active PRE'
    step '(for per) I navigate to "Active PRE" list'
    is_true(on(PumpRoomEntry).is_element_displayed?("xpath", @@pre_number, "text"))
    on(PumpRoomEntry).arrow_back_btn
  end

  if list === 'Closed PRE'
    step 'I navigate to "Closed P/R Entries" screen'
    is_true(on(PumpRoomEntry).is_element_displayed?("xpath", @@pre_number, "text"))
    on(PumpRoomEntry).arrow_back_btn
  end

end

And('I set the activity end time in {int} minutes') do |minutes|
  on(PumpRoomEntry).reduce_time_activity(minutes)
  sleep 90
end

Then(/^I should see current PRE is auto terminated$/) do
  is_true(on(PumpRoomEntry).is_element_displayed?("xpath", @@pre_number, "auto_terminated"))
end

And(/^I should see the table on the page with entered gas data$/) do
  pending
end

Then(/^\(for per\) I navigate to "([^"]*)" list$/) do |item|
  # at the moment we haven't button via sandwich menu for Active PRE, Scheduled PRE, Pending Approval PER
  on(PumpRoomEntry).navigate_for_pre(item)
end

When('I wait to activate PRE. Delay {int}') do |delay|
  sleep delay
end

Then(/^I terminate the PRE$/) do
  step '(for per) I navigate to "Active PRE" list'
  on(PumpRoomEntry).press_button_for_current_PRE("Submit for Termination")
  step 'I enter pin 8383'
  step 'I press the "Terminate" button'
  step 'I enter pin 8383'
  step '(for pre) I sign on canvas'
  step 'I press the "Done" button'
  step 'I press the "Back to Home" button'
end

Then(/^I request update needed$/) do
  step '(for per) I navigate to "Pending approval PRE" list'
  on(PumpRoomEntry).press_button_for_current_PRE("Officer Approval")
  step 'I enter pin 2761'
  sleep 1
  step 'I press the "Updates Needed" button'
  on(PumpRoomEntry).fill_text_input("id", "updatesNeededComment", "Auto test. Update Needed")
  step 'I press the "Submit" button'
  sleep 1
  step "I should see the text 'Your Updates Have Been Successfully Requested'"
  step 'I press the "Back to Home" button'
end

And(/^\(for pre\) I should see update needed message$/) do
  step 'I navigate to "Updates Needed P/R Entries" screen'
  on(PumpRoomEntry).press_button_for_current_PRE("Edit/Update")
  step 'I enter pin 8383'
  step "I should see the text 'Comments from Approving Authority'"
  step "I should see the text 'Auto test. Update Needed'"
end