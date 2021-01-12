And (/^I submit a new entry log$/) do
    sleep 3
    on(PreDisplay).new_entry_log_element.click
    on(PumpRoomEntry).add_all_gas_readings_pre
    step "I sign for gas"
    step 'I enter pin 9015'
    sleep 1
    on(PreDisplay).send_report_element.click
    sleep 3
    step 'I dismiss gas reader dialog box'
    sleep 3
end

Then (/^I should see entrant count equal (.*)$/) do |_count|
    on(PreDisplay).home_tab_element.click
    sleep 1
    is_equal(on(PreDisplay).entrant_count_element.text,_count)
end

And (/^I acknowledge the new entry log via service$/) do
    mod_pre_number = @@pre_number.gsub("/", "%2F")
    sleep 3
    SmartFormDBPage.acknowledge_pre_entry_log(mod_pre_number)
end