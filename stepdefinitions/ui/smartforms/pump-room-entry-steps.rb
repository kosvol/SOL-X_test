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
  is_true(on(PumpRoomEntry).is_question?(_table.raw))
end