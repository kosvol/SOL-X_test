# frozen_string_literal: true

Then (/^I should see section 3a screen$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 3A: DRA - Method & Hazards')
end

When (/^I navigate to section 3a$/) do
  step 'I fill up section 1'
  step 'I proceed to section 3a'
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
  get_time = on(Section3APage).main_clock_element.text
  step 'I get ship-local-time/base-get-current-time request payload'
  step 'I hit graphql'
  sleep 1
  is_true(on(Section3APage).dra_permit_number.include?('SIT/DRA/'))
  is_equal(on(Section3APage).date_and_time_fields_elements[0].text, Time.new.strftime('%d/%b/%Y'))
  is_equal(on(Section3APage).date_and_time_fields_elements[1].text, "#{get_time} LT (GMT+#{ServiceUtil.get_response_body['data']['currentTime']['utcOffset']})")
end

Then (/^I should see Date and Time fields disabled$/) do
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[0]))
  is_true(!is_enabled?(on(Section3APage).date_and_time_fields_elements[1]))
end
