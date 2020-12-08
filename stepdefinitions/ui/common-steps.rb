# frozen_string_literal: true

# Then (/^I should see all section fields enabled$/) do
#   is_false(on(Section1Page).is_fields_enabled?)
#   # step 'I press next from section 1'
# end

# Then (/^I should see all section fields disabled$/) do
#   is_true(!on(Section1Page).is_fields_enabled?)
#   # step 'I press next from section 1'
# end

Then (/^I print$/) do
  p ">> #{WorkWithIndexeddb.get_id_from_indexeddb(@temp_id)}"
  CommonPage.set_permit_id(WorkWithIndexeddb.get_id_from_indexeddb(@temp_id))
end

Then (/^I should map to partial sign details$/) do
  is_true(on(Section4APage).is_partial_signed_user_details_mapped?('9015'))
end

Then (/^I should see display texts match for section1$/) do
  on(Section0Page).labels_scrapper_elements.each do |elem|
    p ">> #{elem.text}"
  end
end

Given (/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  sleep 5
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 2
  # puts "screen size: #{$browser.window_size}"
end

Given (/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  sleep 5
  # puts "screen size: #{$browser.window_size}"
end

When (/^I navigate to "(.+)" screen$/) do |_which_section|
  on(NavigationPage).tap_hamburger_menu
  sleep 1
  on(NavigationPage).select_nav_category(_which_section)
  sleep 1
end

And ('I sleep for {int} seconds') do |sec|
  sleep sec
end

And (/^I click on back arrow$/) do
  on(Section0Page).back_arrow_element.click
end

Then (/^I sign on canvas$/) do
  sleep 1
  on(Section3DPage).sign
end

And ('I enter pin {int}') do |pin|
  @@entered_pin = pin
  sleep 1
  on(PinPadPage).enter_pin(pin)
  sleep 1
end

And(/^I enter pin for rank (.*)$/) do |rank|
  step 'I get pinpad/get-pin-by-role request payload'
  step 'I hit graphql'
  @@entered_pin = on(PinPadPage).get_pin_code(ServiceUtil.get_response_body['data']['users'], rank)
  on(PinPadPage).enter_pin(@@entered_pin)
  sleep 1
end

And (/^I press (next|previous) for (.+) times$/) do |_condition, _times|
  (1.._times.to_i).each do |_i|
    sleep 1
    _condition === 'next' ? on(Section0Page).click_next : on(CommonFormsPage).previous_btn_elements.first.click
  end
end

When (/^I select (.+) permit$/) do |_permit|
  sleep 1
  on(Section0Page).click_permit_type_ddl
  sleep 1
  on(Section0Page).select_level1_permit(_permit)
  step 'I set time'
end

When (/^I select (.+) permit for level 2$/) do |_permit|
  begin
    on(Section0Page).select_level2_permit(_permit)
  rescue StandardError
  end
  sleep 1
  on(Section0Page).save_and_next_btn
  sleep 1
  on(Section0Page).set_selected_level2_permit(_permit)
  step 'I set time'
  @temp_id = on(Section0Page).ptw_id_element.text
  sleep 1
  # p "-- #{on(Section0Page).ptw_id_element.text}"
  # p ">> #{on(CommonFormsPage).get_permit_id_from_access_indexedb(on(Section0Page).ptw_id_element.text)}"
end

And (/^I click on back to home$/) do
  sleep 2
  on(Section6Page).back_to_home_btn_element.click
  sleep 1
end

And (/^I tear down created form$/) do
  begin
    SmartFormDBPage.tear_down_ptw_form(on(Section1Page).get_section1_filled_data[1])
  rescue StandardError
    SmartFormDBPage.tear_down_ptw_form(on(Section0Page).ptw_id_element.text)
  end
end

And (/^I navigate to section (.+)$/) do |_which_section|
  on(Section6Page).toggle_to_section(_which_section)
end

And (/^I set time$/) do
  on(CommonFormsPage).set_current_time
end

And (/^I fill up compulsory fields$/) do
    step 'I sign on checklist with 8383 pin'
    step 'I sign on canvas'
    step 'I press next for 2 times'
    sleep 1
    step 'I fill up section 5'
end

When (/^I fill a full permit$/) do
  step 'I navigate to section 4a'
  step 'I press next for 1 times'
  step 'I fill up checklist yes, no, na'
  step 'I press next for 1 times'
  step 'I select yes to EIC'
  step 'I fill up EIC certificate'
  step 'I press next for 1 times'
  step 'I fill up section 5'
  step 'I press next for 1 times'
  step 'I submit smoke test permit'
  step 'I click on back to home'
  step 'I sleep for 4 seconds'
end