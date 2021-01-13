And (/^I submit a (new|same) entry log$/) do |_condition|
    step 'I sleep for 3 seconds'
    on(PreDisplay).new_entry_log_element.click
    on(PumpRoomEntry).add_all_gas_readings_pre if _condition === 'new'
    on(PumpRoomEntry).add_all_gas_readings if _condition === 'same'
    step "I sign for gas"
    step 'I enter pin 9015'
    step 'I sleep for 1 seconds'
    on(PreDisplay).send_report_element.click
    step 'I sleep for 3 seconds'
    step 'I dismiss gas reader dialog box'
    step 'I sleep for 3 seconds'
end

Then (/^I should see entrant count equal (.*)$/) do |_count|
    on(PreDisplay).home_tab_element.click
    step 'I sleep for 1 seconds'
    is_equal(on(PreDisplay).entrant_count_element.text,_count)
end

And (/^I acknowledge the new entry log via service$/) do
    step 'I sleep for 3 seconds'
    SmartFormDBPage.acknowledge_pre_entry_log
end

Then (/^I shoud not see dashboard gas reading popup$/) do
    step 'I sleep for 3 seconds'
    p ">> #{SmartFormDBPage.acknowledge_pre_entry_log}"
end