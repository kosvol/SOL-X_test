# frozen_string_literal: true

And (/^I should see correct risk evaluation (.+),(.+),(.+)$/) do |_risk, _risk1, _risk2|
  on(Section3APage).evaluation_matrix(_risk, _risk1, _risk2)
end

And (/^I toggle likelihood (.+) and (.+) consequence matrix for (.+)$/) do |likelihood, consequence, _measure|
  @measure = _measure
  case _measure
  when 'without applying measure'
    on(Section3APage).toggle_likelihood_consequence_matrix_without_applying_measure(likelihood, consequence)
  when 'existing control measure'
    on(Section3APage).toggle_likelihood_consequence_matrix_existing_control_measure(likelihood, consequence)
  when 'additional hazard'
    on(Section3APage).toggle_likelihood_consequence_matrix_addition_hazard(likelihood, consequence)
  end
end

Then (/^I should see risk as (.+) risk$/) do |_condition|
  case _condition
  when 'low'
    is_true(on(Section3APage).is_risk_indicator_green?(@measure))
  when 'medium'
    is_true(on(Section3APage).is_risk_indicator_yellow?(@measure))
  when 'high'
    is_true(on(Section3APage).is_risk_indicator_red?(@measure))
  when 'very high'
    is_true(on(Section3APage).is_risk_indicator_veryred?(@measure))
  end
end

Then (/^I should see section 3a screen$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 3A: DRA - Method & Hazards')
end

Then (/^I should see correct likelihood,consequence and risk indicator$/) do
  selected_permit = on(SmartFormsPermissionPage).get_selected_level2_permit
  sleep 1
  is_true(on(Section3APage).is_risk_indicator?(selected_permit))
  is_true(on(Section3APage).is_risk_indicator_color?(selected_permit))
  is_true(on(Section3APage).is_likelihood_value?(selected_permit))
  is_true(on(Section3APage).is_consequence_value?(selected_permit))
end

Then (/^I should see correct DRA page 1 risk indicator content$/) do
  selected_permit = on(SmartFormsPermissionPage).get_selected_level2_permit
  sleep 1
  is_true(on(Section3APage).is_risk_indicator?(selected_permit))
  is_true(on(Section3APage).is_risk_indicator_color?(selected_permit))
end

Then (/^I should see correct DRA page 1 likelihood content$/) do
  selected_permit = on(SmartFormsPermissionPage).get_selected_level2_permit
  sleep 1
  is_true(on(Section3APage).is_likelihood_value?(selected_permit))
end

Then (/^I should see correct DRA page 1 consequence content$/) do
  selected_permit = on(SmartFormsPermissionPage).get_selected_level2_permit
  sleep 1
  is_true(on(Section3APage).is_consequence_value?(selected_permit))
end

Then (/^I should see DRA number,Date and Time populated$/) do
  sleep 1
  on(Section4BPage).set_current_time
  is_true(on(Section3APage).dra_permit_number.include?('SIT/DRA/'))
  is_equal(on(Section3APage).date_and_time_fields_elements[0].text, on(SmartFormsPermissionPage).get_current_date_format)
  is_equal(on(Section3APage).date_and_time_fields_elements[1].text, on(SmartFormsPermissionPage).get_current_time_format)
end

Then (/^I should see Date and Time fields disabled$/) do
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[0]))
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[1]))
end
