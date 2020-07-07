# frozen_string_literal: true

Then (/^I should see correct checklist (.+) pre-selected$/) do |_checklist|
  is_true(on(Section4APage).is_checklist_preselected(_checklist))
end

Then (/^I should see Work on Hazardous Substances checklist exists and uncheck$/) do
  is_true(on(Section4APage).is_hazardous_substance_checklist)
end

Then (/^I should see correct checklist content for (.+) checklist$/) do |_checklist|
  on(Section4APage).select_checklist(_checklist)
  on(Section4APage).next_btn
  sleep 1
  is_equal(on(Section4APage).get_checklist_label('labels', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['labels'])
  is_equal(on(Section4APage).get_checklist_label('sections', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['section'])
  # tmp = on(Section4APage).get_checklist_base_data(_checklist)['section']
  # tmp.each_with_index do |_question, index|
  #   # p ">>> #{on(Section4APage).get_checklist_label('sections', _checklist)[index]}"
  #   is_equal(on(Section4APage).get_checklist_label('sections', _checklist)[index], tmp[index])
  # end
  is_equal(on(Section4APage).get_checklist_label('subheaders', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['subheaders'])
  # tmp = on(Section4APage).get_checklist_base_data(_checklist)['checklist']
  # tmp.each_with_index do |_question, index|
  #   is_equal(on(Section4APage).get_checklist_label('questions', _checklist)[index], tmp[index])
  # end
end

And (/^I select the matching (.+) checklist$/) do |_checklist|
  sleep 1
  on(Section4APage).select_checklist(_checklist)
end

And ('I press next for {int} times') do |_times|
  (1.._times).each do |_i|
    sleep 1
    BrowserActions.scroll_down
    on(Section4APage).next_btn
  end
end

And ('I sign checklist with respective checklist creator {int}') do |_pin|
  step 'I press next for 1 times'
  BrowserActions.scroll_down
  BrowserActions.scroll_down
  on(Section4APage).enter_pin_btn
  @@entered_pin = _pin
  on(PinPadPage).enter_pin(@@entered_pin)
end

Then (/^I should see signed details$/) do
  step 'I get ship-local-time/base-get-current-time request payload'
  step 'I hit graphql'
  on(Section4APage).is_signed_user_details?(@@entered_pin)
end
