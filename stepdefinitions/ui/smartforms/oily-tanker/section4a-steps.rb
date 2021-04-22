# frozen_string_literal: true

Then (/^I should not see location of work in checklist$/) do
  sleep 2
  tmp = @browser.find_elements(:xpath, "//span[contains(., 'Location of work:')]")
  if tmp.size === 0
    tmp = @browser.find_elements(:xpath, "//label[contains(., \"Location of work:\")]")
  elsif tmp.size === 0
    tmp = @browser.find_elements(:xpath, "//p[contains(., \"Location of work:\")]")
  elsif tmp.size === 0
    tmp = @browser.find_element(:xpath, "//h4[contains(., \'Location of work:\')]")
  end
  is_equal(tmp.size,0)
end

And (/^I fill up checklist$/) do
  on(Section4APage).fill_up_checkbox_inputs
  on(Section4APage).fill_textarea(on(Section4APage).input_type_text_elements,'Test automation')
  on(Section4APage).fill_textarea(on(Section4APage).input_type_number_elements,1)
  on(Section4APage).fill_textarea(on(Section4APage).textarea_elements,'Test automation')
  step 'I select PPE equipment'
end

And (/^I fill up section 4a$/) do
  sleep 1
  on(Section4APage).tool_box_elements.first.click
end

Then (/^I should see correct checklist (.+) pre-selected$/) do |_checklist|
  is_true(on(Section4APage).is_checklist_preselected(_checklist))
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

Then (/^I should see signed details$/) do
  if on(Section4APage).is_signed_user_details?(@@entered_pin)
    is_true(on(Section4APage).is_signed_user_details?(@@entered_pin))
  else
    is_true(on(Section4APage).is_signed_user_details_plus_1_min?(@@entered_pin))
  end
  is_true(on(SignaturePage).is_signature_pad?)
end

Then (/^I should see permit number, date and time populated$/) do
  step 'I press next for 1 times'
  is_true(on(Section4APage).is_checklist_details_prepopulated?)
end

And (/^I select PPE equipment$/) do
  BrowserActions.scroll_up
  BrowserActions.scroll_up
  on(Section4APage).select_ppe_equipment
end

And (/^I uncheck the pre-selected checklist$/) do
  sleep 1
  on(Section4APage).uncheck_all_checklist
end

Then (/^I should see this list of available checklist$/) do |_table|
  _table.raw.each_with_index do |_checklist,_index|
    is_equal(_checklist.first,on(Section4APage).list_of_checklist_elements[_index].text)
  end
end

Then (/^I should see (.+) checklist questions$/) do |_checklist|
  sleep 2
  BrowserActions.scroll_down
  @@checklist = _checklist
  base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['questions']
  base_data.each do |_element|
    p ">> #{_element}"
    tmp = @browser.find_elements(:xpath, "//span[contains(., '#{_element}')]")
    if tmp.size === 0
      tmp = @browser.find_elements(:xpath, "//label[contains(., \"#{_element}\")]")
    elsif tmp.size === 0
      tmp = @browser.find_elements(:xpath, "//p[contains(., \"#{_element}\")]")
    elsif tmp.size === 0
      tmp = @browser.find_element(:xpath, "//h4[contains(., \'#{_element}\')]")
    end
    Log.instance.info("Checking on question >>>> #{_element}")
    is_equal(tmp.size,1)
  end
  
  if @@checklist === 'ROL'
    is_equal(on(Section4APage).rol_dd_label_element.text, 'Description of boarding arrangement:')
  end
  
end

And (/^I should see (info|warning|heavy) boxes$/) do |which_box|
  if which_box === 'info'
    box_obj = on(Section4APage).info_box_elements
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['info_box']
  elsif which_box === 'warning'
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['warning_box']
    box_obj = on(Section4APage).warning_box_elements
  elsif which_box === 'heavy'
    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['heavy']
    box_obj = on(Section4APage).heavy_weather_note_elements
  end

  box_obj.each_with_index do |_element, _index|
    p _element.text.to_s
    p (base_data[_index]).to_s
    is_equal(_element.text, base_data[_index])
  end
end

Then (/^I (should|should not) see checklist (.+) fields enabled$/) do |_should_or_not, _condition|
  if _should_or_not === 'should'
    if _condition === 'selections'
      is_equal(on(Section4APage).tool_box_elements.size, 36)
    end
    if _condition === 'questions'
      is_equal(on(Section4APage).tool_box_elements.size, 100)
      is_equal(on(Section4APage).textarea_elements.size, 2)
      # is_enabled(on(Section4APage).enter_pin_btn_element)
    end
  end
  if _should_or_not === 'should not'
    if _condition === 'selections'
      is_equal(on(Section4APage).tool_box_elements.size, 0)
    end
    if _condition === 'questions'
      is_equal(on(Section4APage).tool_box_elements.size, 0)
      is_equal(on(Section4APage).textarea_elements.size, 0)
    end
  end
end

Then (/^I should see rol checklist questions fields enabled$/) do
  is_equal(on(Section4APage).tool_box_elements.size, 48)
  is_equal(on(ROLPage).boarding_ddl_elements.size, 1)
end

And (/^I should not see enter pin button$/) do
  sleep 1
  is_disabled(on(Section4APage).enter_pin_btn_element)
end
