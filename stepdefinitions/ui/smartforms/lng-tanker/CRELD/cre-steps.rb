Then (/^I should see CRE form questions$/) do
    on(CommonFormsPage).match_screen_labels(on(Section4APage).section4a_elements)
end

Then (/^I (should|should not) see CRE landing screen$/) do |_condition|
    if _condition === 'should'
      is_true(on(PumpRoomEntry).heading_text == "Compressor/Motor Room Entry" )
    end
end