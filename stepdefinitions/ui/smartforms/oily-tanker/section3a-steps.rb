# frozen_string_literal: true

Then(/^I (should|should not) see request update comment box$/) do |_condition|
  if _condition === 'should'
    to_exists(on(Section0Page).enter_comment_box_element)
    is_equal(on(Section3APage).enter_comment_box_element.text, 'Test Automation')
  elsif _condition === 'should not'
    not_to_exists(on(Section0Page).enter_comment_box_element)
  end
end

Then(/^I (should|should not) see request update comment$/) do |_condition|
  if _condition === 'should'
    # is_equal(on(Section3APage).total_p_elements.size, 6)
    is_equal(on(Section3APage).total_p_elements.first.text, 'Test Automation')
  elsif _condition === 'should not'
    is_not_equal(on(Section3APage).total_p_elements.first.text, 'Test Automation')
    is_equal(on(Section3APage).total_p_elements.size, 8)
  end
end

Then(/^I should see fields disabled$/) do
  is_equal(on(Section3APage).total_p_elements.size, 14)
  is_equal(on(Section3APage).delete_btn_elements.size, 0)
end

And(/^I should see correct risk evaluation (.+),(.+),(.+)$/) do |_risk, _risk1, _risk2|
  is_true(on(Section3APage).evaluation_matrix(_risk, _risk1, _risk2))
end

Then(/^I should see DRA content editable$/) do
  sleep 1
  is_equal(on(CommonFormsPage).enter_comment_boxes_elements.size, 12)
  to_exists(on(Section3APage).save_dra_element)
end

And(/^I toggle likelihood (.+) and (.+) consequence matrix for (.+)$/) do |likelihood, consequence, _measure|
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
    @@swap_flag = 'evaluation_matrix'
    on(Section3APage).toggle_likelihood_consequence_matrix_addition_hazard(likelihood, consequence)
  end
  sleep 1
end

Then(/^I should see risk as (.+) risk$/) do |_condition|
  case _condition
  when 'low'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure, 'low'))
  when 'medium'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure, 'medium'))
  when 'high'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure, 'high'))
  when 'very high'
    is_true(on(Section3APage).is_risk_indicator_color?(@measure, 'very high'))
  end
end

Then(/^I should see section 3a screen$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 3A: DRA - Method & Hazards')
end

Then(/^I should see DRA number,Date and Time populated$/) do
  sleep 1
  is_equal(on(Section3APage).generic_data_elements.first.text, EnvironmentSelector.get_vessel_name)
  does_include(on(Section3APage).generic_data_elements[1].text, 'DRA/TEMP/')
  is_equal(on(Section3APage).generic_data_elements[2].text, @get_permit_creation_datetime)
end

Then(/^I should see Date and Time fields disabled$/) do
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[0]))
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[1]))
end

And(/^I add a additional hazard$/) do
  step 'I toggle likelihood 1 and 1 consequence matrix for additional hazard'
  BrowserActions.enter_text(on(Section3APage).description_elements[2], 'Test Automation')
  on(Section3APage).save_dra
end

And(/^I click on View Edit Hazard$/) do
  on(Section3APage).view_edit_btn
end

Then(/^I should see additional hazard data save$/) do
  on(Section3APage).navigate_front_back
  is_true(on(Section3APage).is_additional_hazard_saved?)
end

And(/^I add a new hazard$/) do
  on(Section3APage).add_new_hazard
end

And(/^I delete a hazard$/) do
  sleep 1
  on(Section3APage).view_edit_btn
  sleep 1
  on(Section3APage).delete_btn_elements.first.click
  sleep 1
  on(Section3APage).delete_btn_elements.last.click
  sleep 2
  on(Section3APage).save_dra
  sleep 1
end

Then(/^I should see hazard deleted$/) do
  sleep 2
  on(Section3APage).scroll_multiple_times_with_direction(2,'down')
  is_equal(on(Section3APage).identified_hazard_name_elements[0].text, 'Personal injury')
  is_equal(on(Section3APage).identified_hazard_name_elements[1].text, 'Falling down anchor chain')
  is_equal(on(Section3APage).identified_hazard_name_elements.size, '2')
end

Then(/^I should see added new hazard$/) do
  on(Section3APage).navigate_front_back
  BrowserActions.scroll_click(on(Section3APage).view_edit_btn_element)
  on(Section3APage).scroll_to_new_hazard
  BrowserActions.scroll_up
  is_true(on(Section3APage).is_new_hazard_added?)
end
