And(/^I navigate to create new PRE$/) do
  on(PumpRoomEntry).click_create_pump_room_entry
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
    is_true(on(PumpRoomEntry).is_alert_text_visible?(alert))
  end

  if _condition === 'should not'
    is_false(on(PumpRoomEntry).is_alert_text_visible?(alert))
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
  if _condition === 'should not'
    is_false(on(PumpRoomEntry).is_interval_period_displayed?)
  end

  if _condition === 'should'
    is_true(on(PumpRoomEntry).is_interval_period_displayed?)
  end
end

Then(/^I press the "([^"]*)" button$/) do |button|
  on(PumpRoomEntry).press_the_button(button)
end

And(/^I should see the page "([^"]*)"$/) do |section|
  is_true(on(PumpRoomEntry).is_page?(section))
end

And(/^\(for pre\) I should see the (disabled|enabled) "([^"]*)" button$/) do |_condition, button|
  if _condition === 'disabled'
    is_false(on(PumpRoomEntry).is_button_enabled?(button))
  end

  if _condition === 'enabled'
    is_true(on(PumpRoomEntry).is_button_enabled?(button))
  end
end

And(/^I fill up "([^"]*)"$/) do |section|
  is_true(on(PumpRoomEntry).fill_up_section?(section))
end

And(/^I should see a new row with filled data$/) do
  is_true(on(PumpRoomEntry).how_many_rows == 1)
end

And(/^I should be able to delete the record$/) do
  is_true(on(PumpRoomEntry).delete_added_row)
end

Then(/^\(for pre\) I sign on canvas$/) do
  on(PumpRoomEntry).sign
end


And('I sign on Gas Test Record with {int} pin') do |_pin|
  on(PinPadPage).enter_pin(_pin)
end

Then(/^I fill up PRE. Duration ([^"]*)$/) do|_duration|
  on(PumpRoomEntry).fill_up_pre(_duration)
end


And(/^\(for pre\) I submit permit for Officer Approval$/) do
  @@pre_number = on(PumpRoomEntry).get_pre_no
  step 'I press the "Submit for Approval" button'
  step 'I enter pin 8383'
  step '(for pre) I sign on canvas'
  step 'I press the "Done" button'
  sleep 1
  step 'I should see the page "Successfully Submitted"'
  step 'I press the "Back to Home" button'
end