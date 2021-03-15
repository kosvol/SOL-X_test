And (/^I enter (new|same) entry log$/) do |_condition|
    step 'I sleep for 8 seconds'
    on(PreDisplay).new_entry_log_element.click
    
    on(PumpRoomEntry).add_all_gas_readings_pre('1','2','3','4','Test','20','1.5','cc') if _condition === 'same'
    on(PumpRoomEntry).add_all_gas_readings_pre('2','3','4','5','Test','20','2','cc') if _condition === 'new'
    step "I sign for gas"
    step 'I enter pin 9015'
    step 'I sleep for 1 seconds'
end

Then (/^I should see correct signed in entrants$/) do
    on(PumpRoomEntry).home_tab_element.click
    is_equal(on(PumpRoomEntry).signed_in_entrants_elements.first.text,"A/M Atif Hayat")
    is_equal(on(PumpRoomEntry).signed_in_entrants_elements.size,1)
end

Then (/^I should not see entered entrant on list$/) do
    on(PreDisplay).home_tab_element.click
    is_false(on(PumpRoomEntry).is_entered_entrant_listed?("MAS Daniel Alcantara"))
end

And ("I send entry report with {int} optional entrants") do |_optional_entrant|
    on(PumpRoomEntry).additional_entrant(_optional_entrant) if _optional_entrant > 0
    sleep 1
    BrowserActions.js_click("//span[contains(text(),'Send Report')]")
end

Then (/^I should see entrant count equal (.*)$/) do |_count|
    on(PreDisplay).home_tab_element.click
    step 'I sleep for 1 seconds'
    if _count === "0"
        not_to_exists(on(PreDisplay).entrant_count_element)
    else
        is_equal(on(PreDisplay).entrant_count_element.text,_count)
    end
end

And (/^I acknowledge the new entry log via service$/) do
    step 'I sleep for 4 seconds'
    SmartFormDBPage.acknowledge_pre_entry_log
    step 'I sleep for 3 seconds'
end

Then (/^I (shoud not|should) see dashboard gas reading popup$/) do |_condition|
    step 'I acknowledge the new entry log via service'
    step 'I sleep for 1 seconds'
    if _condition === 'should not'
        is_equal(SmartFormDBPage.get_error_message,"No pending PRED record")
    elsif _condition === 'should'
        ServiceUtil.get_response_body['data']['acknowledgeUnsafeGasReading']
    end
end

And (/^I terminate from dashboard$/) do
    ## pending frontend implementation
end

And ("I signout {int} entrants") do |total_entrants|
end