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
  on(Section4APage).section1_elements.each_with_index do |_element,_index|
    is_equal(_element.text,_table.raw[_index].first)
  end
  is_equal(on(PumpRoomEntry).all_inputs_elements.size,39)
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