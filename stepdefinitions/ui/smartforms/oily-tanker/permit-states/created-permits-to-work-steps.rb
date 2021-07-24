# frozen_string_literal: true

Then(/^I should see the newly created permit details listed on Created Permits to Work$/) do
  on(Section1Page).set_section1_filled_data(CommonPage.get_entered_pin, 'Created By')
  does_include(on(CreatedPermitToWorkPage).ptw_id_elements.first.text,
               "#{$current_environment.upcase}/PTW/#{BrowserActions.get_year}/")
  is_equal(on(Section1Page).get_section1_filled_data[2], on(CreatedPermitToWorkPage).created_by_elements.first.text)
  is_equal(on(Section1Page).get_section1_filled_data[3],
           on(CreatedPermitToWorkPage).created_date_time_elements.first.text)
end

And(/^I want to edit the newly created permit$/) do
  # on(CreatedPermitToWorkPage).select_created_permit_with_param(CommonPage.get_permit_id).click
  on(CreatedPermitToWorkPage).edit_permit_btn_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].click
end

Then(/^I should see correct permit details$/) do
  on(Section1Page).set_section1_filled_data(CommonPage.get_entered_pin, 'Created By')
  is_equal(on(Section0Page).generic_data_elements[0].text, 'SOLX Automation Test')
  is_equal(on(Section0Page).generic_data_elements[1].text, on(Section1Page).get_section1_filled_data[0])
  # does_include(on(Section0Page).generic_data_elements[1].text, "#{$current_environment.upcase}/PTW/#{BrowserActions.get_year}/")
  # is_equal(on(Section0Page).generic_data_elements[1].text, on(Section1Page).get_section1_filled_data[1])
end

And(/^I edit ptw with rank (.+)$/) do |_rank|
  step 'I want to edit the newly created permit'
  step "I enter pin for rank #{_rank}"
end

And(/^I should see eic selection fields enabled$/) do
  sleep 1
  is_enabled(on(Section4BPage).yes_no_btn_elements[0])
  is_enabled(on(Section4BPage).yes_no_btn_elements[1])
end

And(/^I should see gas reading section with fields enabled$/) do
  step 'I press next for 2 times'
  is_enabled(on(Section6Page).gas_yes_no_elements[0])
  is_enabled(on(Section6Page).gas_yes_no_elements[1])
end

Then(/^I should see EIC section with fields enabled$/) do
  is_equal(on(Section4APage).disabled_fields_elements.size, '2')
end

Then(/^I should see deleted permit deleted$/) do
  sleep 1
  is_true(on(CreatedPermitToWorkPage).is_created_permit_deleted?)
end

And(/^I delete the permit created$/) do
  CommonPage.set_permit_id(on(CreatedPermitToWorkPage).ptw_id_elements.first.text)
  on(CreatedPermitToWorkPage).delete_permit_btn_elements.first.click
  step 'I enter pin for rank MAS'
end

Then(/^I should see the total permits in CREATED state match backend results$/) do
  on(Section3APage).scroll_multiple_times(15)
  sleep 1
  step 'I get forms-filter/get-created-permits request payload'
  step 'I hit graphql'
  is_equal(ServiceUtil.get_response_body['data']['formStats']['created'],
           on(CreatedPermitToWorkPage).parent_container_elements.size)
end
