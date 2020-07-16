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
  # on(Section4APage).get_checklist_label('section2', _checklist).each do |tmp|
  #   p ">>> #{tmp}"
  # end
  # p ">>> #{on(Section4APage).get_checklist_label('section1', _checklist)}"

  is_equal(on(Section4APage).get_checklist_label('labels', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['labels'])
  # is_equal(on(Section4APage).get_checklist_label('subheaders', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['subheaders'])
  is_equal(on(Section4APage).get_checklist_label('sections', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['section'])
  is_equal(on(Section4APage).get_checklist_label('section1', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['section1'])
  is_equal(on(Section4APage).get_checklist_label('section2', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['section2'])
  is_equal(on(Section4APage).get_checklist_label('info_box', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['info_box'])
  is_equal(on(Section4APage).get_checklist_label('warning_box', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['warning_box'])
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
  # BrowserActions.scroll_down
  # BrowserActions.scroll_down
  # BrowserActions.scroll_down
  # BrowserActions.scroll_down
  step "I sign on section with #{_pin} pin"
end

And (/^I sign on section with (.+) pin$/) do |_pin|
  on(Section4APage).enter_pin_btn
  @@entered_pin = _pin
  on(PinPadPage).enter_pin(@@entered_pin)
end

Then (/^I should see signed details$/) do
  on(SmartFormsPermissionPage).set_current_time
  on(Section4APage).is_signed_user_details?(@@entered_pin)
end

Then (/^I should see permit number, date and time populated$/) do
  step 'I press next for 1 times'
  is_true(on(Section4APage).is_checklist_details_prepopulated?)
end

And (/^I fill up checklist yes, no, na$/) do
  tmp = 0
  (0..((on(Section3DPage).radio_btn_elements.size / 3) - 1)).each do |_i|
    on(Section3DPage).radio_btn_elements[0 + tmp].click
    # on(Section3DPage).radio_btn_elements[[0 + tmp, 1 + tmp, 2 + tmp].sample].click
    tmp += 3
  end
end
