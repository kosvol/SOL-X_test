Then (/^I should see CRE form questions$/) do
  on(CommonFormsPage).match_screen_elements(YAML.load_file('data/cre/cre-forms.yml')['questions'])
end

Then (/^I (should|should not) see CRE landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).heading_text == 'Compressor/Motor Room Entry')
  end
end
