# frozen_string_literal: true

Then (/^I print all text$/) do
  tmp = $browser.find_elements(:xpath, "//html/body")
  tmp.each do |_t|
    p ">> #{_t.text}"
  end
end

And (/^I turn (off|on) wifi$/) do |on_or_off|
  BrowserActions.turn_wifi_off_on
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
  $browser.get(EnvironmentSelector.get_environment_url)
  BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  # puts "screen size: #{$browser.window_size}"
end

Given (/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  # puts "screen size: #{$browser.window_size}"
end

When (/^I navigate to "(.+)" screen$/) do |_which_section|
  BrowserActions.poll_exists_and_click(on(NavigationPage).hamburger_menu_element)
  # on(NavigationPage).tap_hamburger_menu
  sleep 1
  on(NavigationPage).select_nav_category(_which_section)
  sleep 1
end

And ('I sleep for {int} seconds') do |sec|
  sleep sec
end

And (/^I click on back arrow$/) do
  on(Section0Page).back_arrow_element.click
  sleep 2
  step 'I set permit id'
end

Then (/^I sign on canvas$/) do
  sleep 1
  on(Section3DPage).sign
end

And ('I enter pin {int}') do |pin|
  @@entered_pin = pin
  sleep 1
  on(PinPadPage).enter_pin(pin)
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
    # sleep 1
    _condition === 'next' ? BrowserActions.poll_exists_and_click(on(Section0Page).click_next_element) : BrowserActions.poll_exists_and_click(on(CommonFormsPage).previous_btn_elements.first)
  end
end

When (/^I select (.+) permit$/) do |_permit|
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  on(Section0Page).select_level1_permit(_permit)
end

When (/^I select (.+) permit for level 2$/) do |_permit|
  @via_service_or_not = false
  begin
    on(Section0Page).select_level2_permit(_permit)
  rescue StandardError
  end
  BrowserActions.poll_exists_and_click(on(Section0Page).save_and_next_btn_element)
  on(Section0Page).set_selected_level2_permit(_permit)
  step 'I set time'
  @temp_id = on(Section0Page).ptw_id_element.text
end

And (/^I click on back to home$/) do
  BrowserActions.poll_exists_and_click(on(Section6Page).back_to_home_btn_element)
  sleep 5
  # step 'I set permit id'
end

And (/^I set permit id$/) do
  if @via_service_or_not === false
    p "Temp ID >> #{@temp_id}"
    CommonPage.set_permit_id(WorkWithIndexeddb.get_id_from_indexeddb(@temp_id))
  end
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
    step 'I press next for 1 times'
    sleep 1
    step 'I select yes to EIC'
    step 'I fill up EIC certificate'
    step 'I press next for 1 times'
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
  on(Section3APage).scroll_multiple_times(3)
  step 'I submit smoke test permit'
  step 'I sleep for 2 seconds'
  step 'I click on back to home'
  step 'I sleep for 3 seconds'
end