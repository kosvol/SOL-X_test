And(/^I navigate to create new PRE$/) do
  on(PumpRoomEntry).click_create_pump_room_entry
  sleep 1
end

Then (/^I (should|should not) see PRE landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).ptw_id_element.text.include?('PRE/TEMP/'))
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
  if button == "Add Gas Test Record"
    on(PumpRoomEntry).send(:add_gas_record_btn)
  elsif button == "Continue"
    on(PumpRoomEntry).press_the_button("Continue")
  elsif button == "Add Toxic Gas"
    on(PumpRoomEntry).press_the_button("Add Toxic Gas")
  end
end

And(/^I should see the section "([^"]*)"$/) do |section|
  is_true(on(PumpRoomEntry).is_section?(section))
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

Then(/^I should be able to delete the record$/) do
  is_true(on(PumpRoomEntry).delete_added_row)
end