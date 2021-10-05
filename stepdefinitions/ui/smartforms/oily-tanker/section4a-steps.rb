# frozen_string_literal: true

Then(/^I should not see location of work in checklist$/) do
  sleep 2
  %w[span label p h4].each do |element|
    tmp = @browser.find_elements(:xpath, "//#{element}[contains(., 'Location of work:')]")
    raise "Location of Work is present on screen #{element}" if is_not_equal(tmp.size, 0)
  end
end

And(/^I fill up checklist$/) do
  on(Section4APage).fill_up_checkbox_inputs
  on(Section4APage).fill_textarea(on(Section4APage).input_type_text_elements, 'Test automation')
  on(Section4APage).fill_textarea(on(Section4APage).input_type_number_elements, 1)
  on(Section4APage).fill_textarea(on(Section4APage).textarea_elements, 'Test automation')
  step 'I select PPE equipment'
end

And(/^I fill up section 4a$/) do
  sleep 1
  on(Section4APage).tool_box_elements.first.click
end

Then(/^I should see correct checklist (.+) pre-selected$/) do |checklist|
  is_true(on(Section4APage).is_checklist_preselected(checklist))
end

Then(/^I should see correct checklist content for (.+) checklist$/) do |checklist|
  on(Section4APage).select_checklist(checklist)
  step 'I press next for 1 times'
  sleep 1
  is_equal(on(Section4APage).get_checklist_label('labels', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['labels'])
  is_equal(on(Section4APage).get_checklist_label('subheaders', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['subheaders'])
  is_equal(on(Section4APage).get_checklist_label('sections', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['section'])
  is_equal(on(Section4APage).get_checklist_label('section1', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['section1'])
  is_equal(on(Section4APage).get_checklist_label('section2', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['section2'])
  is_equal(on(Section4APage).get_checklist_label('info_box', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['info_box'])
  is_equal(on(Section4APage).get_checklist_label('warning_box', checklist),
           on(Section4APage).get_checklist_base_data(checklist)['warning_box'])
end

And(/^I select the matching (.+) checklist$/) do |checklist|
  sleep 1
  on(Section4APage).select_checklist(checklist)
end

Then(/^I should see signed details$/) do
  on(Section4APage).signature_scroll
  if on(Section4APage).is_signed_user_details?(CommonPage.get_entered_pin)
    is_true(on(Section4APage).is_signed_user_details?(CommonPage.get_entered_pin))
  else
    is_true(on(Section4APage).is_signed_user_details_plus_1_min?(CommonPage.get_entered_pin))
  end
  is_true(on(SignaturePage).is_signature_pad?)
end

Then(/^I should see permit number, date and time populated$/) do
  step 'I press next for 1 times'
  is_true(on(Section4APage).is_checklist_details_prepopulated?)
end

And(/^I select PPE equipment$/) do
  BrowserActions.scroll_up
  BrowserActions.scroll_up
  on(Section4APage).select_ppe_equipment
end

And(/^I uncheck the pre-selected checklist$/) do
  sleep 1
  on(Section4APage).uncheck_all_checklist
end

Then(/^I should see this list of available checklist$/) do |table|
  table.raw.each_with_index do |checklist, index|
    is_equal(checklist.first, on(Section4APage).list_of_checklist_elements[index].text)
  end
end

Then(/^I should see (.+) checklist questions$/) do |checklist|
  sleep 2
  BrowserActions.scroll_down
  @@checklist = checklist
  is_true(on(Section4APage).is_checklist_questions?)
end

And(/^I should see (info|warning|heavy) boxes$/) do |which_box|
  case which_box
  when 'info'
    box_obj = on(Section4APage).info_box_elements
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['info_box']
  when 'warning'
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['warning_box']
    box_obj = on(Section4APage).warning_box_elements
  when 'heavy'
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['heavy']
    box_obj = on(Section4APage).heavy_weather_note_elements
  else
    raise "Wrong box type #{which_box}"
  end

  box_obj.each_with_index do |element, index|
    p element.text.to_s
    p (base_data[index]).to_s
    is_equal(element.text, base_data[index])
  end
end

Then(/^I (should|should not) see checklist (.+) fields enabled$/) do |should_or_not, condition|
  if should_or_not == 'should'
    is_equal(on(Section4APage).tool_box_elements.size, 36) if condition == 'selections'
    if condition == 'questions'
      is_equal(on(Section4APage).tool_box_elements.size, 100)
      is_equal(on(Section4APage).textarea_elements.size, 2)
    end
  end
  if should_or_not == 'should not'
    is_equal(on(Section4APage).tool_box_elements.size, 0) if condition == 'selections'
    if condition == 'questions'
      is_equal(on(Section4APage).tool_box_elements.size, 0)
      is_equal(on(Section4APage).textarea_elements.size, 0)
    end
  end
end

Then(/^I should see rol checklist questions fields enabled$/) do
  is_equal(on(Section4APage).tool_box_elements.size, 48)
  is_equal(on(ROLPage).boarding_ddl_elements.size, 1)
end

And(/^I should not see enter pin button$/) do
  sleep 1
  is_disabled(on(Section4APage).enter_pin_btn_element)
end
