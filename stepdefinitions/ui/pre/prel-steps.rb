And (/^I submit a new entry log$/) do
    on(PreDisplay).new_entry_log_element.click
    on(Section6Page).add_all_gas_readings_pre
    step "I sign for gas"
    step 'I enter pin 9015'
    sleep 1
    on(PreDisplay).send_report_element.click
    step 'I dismiss gas reader dialog box'
end

Then (/^I should see entrant count equal (.*)$/) do |_count|
    on(PreDisplay).home_tab_element.click
    sleep 1
    is_equal(on(PreDisplay).entrant_count_element.text,_count)
end