# frozen_string_literal: true

# Then (/^I print all text$/) do
#   tmp = $browser.find_elements(:xpath, "//html/body")
#   tmp.each do |_t|
#     p ">> #{_t.text}"
#   end
# end

And (/^I turn (off|on) wifi$/) do |on_or_off|
  BrowserActions.turn_wifi_off_on
end

# Then (/^I should map to partial sign details$/) do
#   is_true(on(Section4APage).is_partial_signed_user_details_mapped?('9015'))
# end

Then (/^I should see display texts match for section1$/) do
  on(Section0Page).labels_scrapper_elements.each do |elem|
    p ">> #{elem.text}"
  end
end

Given (/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  $browser.get(EnvironmentSelector.get_environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue 
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
  sleep 5
  # puts "screen size: #{$browser.window_size}"
end

Given (/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue 
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
  sleep 5
  # puts "screen size: #{$browser.window_size}"
end

And ('I sleep for {int} seconds') do |sec|
  sleep sec
end

Then (/^I sign on canvas with (invalid|valid) (.*) pin$/) do |_condition,_pin|
  step 'I sleep for 1 seconds'
  step "I enter pin #{_pin}"
  on(SignaturePage).sign_and_done if _condition != "invalid"
end

And ('I enter pin {int}') do |pin|
  @@entered_pin = pin
  on(PinPadPage).enter_pin(pin)
end

And(/^I enter pin for rank (.*)$/) do |rank|
  step 'I get pinpad/get-pin-by-role request payload'
  step 'I hit graphql'
  @@entered_pin = on(PinPadPage).get_pin_code(ServiceUtil.get_response_body['data']['users'], rank)
  on(PinPadPage).enter_pin(@@entered_pin)
  sleep 1
end

When (/^I select (.+) permit$/) do |_permit|
  sleep 1
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  on(Section0Page).select_level1_permit(_permit)
end

When (/^I select (.+) permit for level 2$/) do |_permit|
  @via_service_or_not = false
  on(Section0Page).select_level2_permit_and_next(_permit)
  sleep 2
  @temp_id = on(Section0Page).ptw_id_element.text
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

And (/^I set time$/) do
  on(CommonFormsPage).set_current_time
end