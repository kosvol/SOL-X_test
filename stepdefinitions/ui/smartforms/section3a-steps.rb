# frozen_string_literal: true

And (/^I should see correct risk evaluation (.+),(.+),(.+)$/) do |_risk, _risk1, _risk2|
  is_true(on(Section3APage).evaluation_matrix(_risk, _risk1, _risk2))
end

And (/^I toggle likelihood (.+) and (.+) consequence matrix for (.+)$/) do |likelihood, consequence, _measure|
  sleep 1
  @measure = _measure
  @@swap_flag = ''
  case _measure
  when 'without applying measure'
    on(Section3APage).toggle_likelihood_consequence_matrix_without_applying_measure(likelihood, consequence)
  when 'existing control measure'
    on(Section3APage).toggle_likelihood_consequence_matrix_existing_control_measure(likelihood, consequence)
  when 'additional hazard'
    on(Section3APage).toggle_likelihood_consequence_matrix_addition_hazard(likelihood, consequence)
  when 'additional hazard follow through'
    @@swap_flag = "evaluation_matrix"
    on(Section3APage).toggle_likelihood_consequence_matrix_addition_hazard(likelihood, consequence)
  end
end

Then (/^I should see risk as (.+) risk$/) do |_condition|
  case _condition
  when 'low'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure,"low"))
  when 'medium'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure,"medium"))
  when 'high'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure,"high"))
  when 'very high'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure,"very high"))
  end
end

Then (/^I should see section 3a screen$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 3A: DRA - Method & Hazards')
end

Then (/^I should see DRA number,Date and Time populated$/) do
  sleep 1
  does_include(on(Section3APage).generic_data_elements[1].text, "SIT/DRA/#{BrowserActions.get_year}/")
  is_equal(on(Section3APage).date_and_time_fields_elements[0].text, on(Section0Page).get_current_date_format_with_offset)
  is_equal(on(Section3APage).date_and_time_fields_elements[1].text, on(Section0Page).get_current_time_format)
end

Then (/^I should see Date and Time fields disabled$/) do
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[0]))
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[1]))
end

And (/^I add a additional hazard$/) do
  step 'I toggle likelihood 1 and 1 consequence matrix for additional hazard'
  BrowserActions.enter_text(on(Section3APage).description_elements[2], 'Test Automation')
  on(Section3APage).save_dra
end

And (/^I click on View Edit Hazard$/) do
  on(Section3APage).view_edit_btn
end

Then (/^I should see additional hazard data save$/) do
  on(Section3APage).navigate_front_back
  is_true(on(Section3APage).is_additional_hazard_saved?)
end

And (/^I add a new hazard$/) do
  on(Section3APage).add_new_hazard
end

And (/^I delete a hazard$/) do
  sleep 1
  on(Section3APage).view_edit_btn
  sleep 1
  on(Section3APage).delete_btn_elements.first.click
  sleep 2
  on(Section3APage).save_dra
  sleep 1
end

Then (/^I should see hazard deleted$/) do
  sleep 1
  on(Section3APage).scroll_multiple_times(1)
  is_equal(on(Section3APage).identified_hazard_name_elements.size, '2')
  is_equal(on(Section3APage).identified_hazard_name_elements[0].text, 'Personal injury')
  is_equal(on(Section3APage).identified_hazard_name_elements[1].text, 'Falling down anchor chain')
end

Then (/^I should see added new hazard$/) do
  on(Section3APage).navigate_front_back
  BrowserActions.scroll_click(on(Section3APage).view_edit_btn_element)
  on(Section3APage).scroll_multiple_times(15)
  is_true(on(Section3APage).is_new_hazard_added?)
end
