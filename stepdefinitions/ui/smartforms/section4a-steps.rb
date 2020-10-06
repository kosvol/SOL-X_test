# frozen_string_literal: true

And (/^I fill up section 4a$/) do
  sleep 1
  on(Section4APage).tool_box_elements.first.click
end

Then (/^I should see correct checklist (.+) pre-selected$/) do |_checklist|
  is_true(on(Section4APage).is_checklist_preselected(_checklist))
end

Then (/^I should see Work on Hazardous Substances checklist exists and uncheck$/) do
  is_true(on(Section4APage).is_hazardous_substance_checklist?)
end

Then (/^I should see correct checklist content for (.+) checklist$/) do |_checklist|
  on(Section4APage).select_checklist(_checklist)
  step 'I press next for 1 times'
  sleep 1
  is_equal(on(Section4APage).get_checklist_label('labels', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['labels'])
  is_equal(on(Section4APage).get_checklist_label('subheaders', _checklist), on(Section4APage).get_checklist_base_data(_checklist)['subheaders'])
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

And ('I sign on section with {int} pin') do |_pin|
  BrowserActions.scroll_click(on(Section4APage).sign_btn_elements.first)
  @@entered_pin = _pin
  on(PinPadPage).enter_pin(@@entered_pin)
end

And ('I sign on checklist with {int} pin') do |_pin|
  on(Section3APage).scroll_multiple_times(4)
  on(Section4APage).enter_pin_btn
  @@entered_pin = _pin
  on(PinPadPage).enter_pin(@@entered_pin)
  step 'I sign on canvas'
end

Then (/^I should see signed details$/) do
  on(CommonFormsPage).set_current_time
  on(Section4APage).is_signed_user_details?(@@entered_pin)
  is_true(on(Section4APage).is_signature_pad?)
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
  begin
    on(Section4APage).fill_textarea
    on(Section4APage).interval = '1'
  rescue StandardError
  end
end

And (/^I select PPE equipment$/) do
  BrowserActions.scroll_up
  BrowserActions.scroll_up
  on(Section4APage).select_ppe_equipment
end

And (/^I uncheck the pre-selected checklist$/) do
  on(Section4APage).uncheck_all_checklist
end

Then (/^I should see (.+) checklist questions$/) do |checklist|
  @@checklist = checklist
  base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['questions']
  on(Section4APage).section1_elements.each_with_index do |_element,_index|
    p "#{_element.text}"
    p "#{base_data[_index]}"
    is_equal(_element.text,base_data[_index])
  end
end

And (/^I should see (info|warning|heavy) boxes$/) do |which_box|
  if which_box === "info" 
    box_obj = on(Section4APage).info_box_elements
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['info_box']
  elsif which_box === "warning" 
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['warning_box']
    box_obj = on(Section4APage).warning_box_elements
  elsif which_box === "heavy" 
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['heavy']
    box_obj = on(Section4APage).heavy_weather_note_elements
  end

  box_obj.each_with_index do |_element,_index|
    p "#{_element.text}"
    p "#{base_data[_index]}"
    is_equal(_element.text,base_data[_index])
  end
end

Then (/^I (should|should not) see checklist (.+) fields enabled$/) do |_should_or_not,_condition|
  if _should_or_not === "should"
    is_equal(on(Section4APage).tool_box_elements.size,36) if _condition === "selections"
    if _condition === "questions"
      is_equal(on(Section4APage).tool_box_elements.size,100)
      is_equal(on(Section4APage).textarea_elements.size,2)
      is_enabled(on(Section4APage).enter_pin_btn_element)
    end
  end
  if _should_or_not === "should not"
    is_equal(on(Section4APage).tool_box_elements.size,0) if _condition === "selections"
    if _condition === "questions"
      is_equal(on(Section4APage).tool_box_elements.size,1)
      is_equal(on(Section4APage).textarea_elements.size,0)
    end
  end
end

Then (/^I should see rol checklist questions fields enabled$/) do
  is_equal(on(Section4APage).tool_box_elements.size,48)
  is_equal(on(ROLPage).boarding_ddl_elements.size,1)
end

And (/^I should not see enter pin button$/) do
  sleep 1
  is_disabled(on(Section4APage).enter_pin_btn_element)
end