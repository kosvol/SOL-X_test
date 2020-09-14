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


Then(/^I should see all questions for PRE$/) do |_table|
  is_true(on(PumpRoomEntry).is_questions?(_table.raw))
end

Then(/^I (should|should not) see alert message "(.*)"$/) do |_condition, _alert|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).is_alert_text_visible?(_alert))
  end

  if _condition === 'should not'
    is_false(on(PumpRoomEntry).is_alert_text_visible?(_alert))
  end
end

Then(/^I select Permit Duration (.*)$/) do |duration|
  on(PumpRoomEntry).select_permit_duration(duration)
end

And(/^Button "([^"]*)" (should|should not) be disabled$/) do |_button_text, _condition|
  if _condition === 'should'
    is_false(on(PumpRoomEntry).is_button_enabled?(_button_text))
  end

  if _condition === 'should not'
    is_true(on(PumpRoomEntry).is_button_enabled?(_button_text))
  end
end