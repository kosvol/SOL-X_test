# frozen_string_literal: true

And (/^I turn (off|on) wifi$/) do |on_or_off|
  BrowserActions.turn_wifi_off_on
end

Given (/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  $browser.get(EnvironmentSelector.get_environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end

Given (/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue
    begin
      BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
    rescue
      BrowserActions.wait_until_is_visible(on(Section0Page).uat_create_permit_btn_element)
    end
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end

And ('I sleep for {int} seconds') do |sec|
  sleep sec
end

And (/^I sign on canvas$/) do
  on(SignaturePage).sign_and_done
end

Then (/^I sign on canvas with (invalid|valid) (.*) pin$/) do |_condition,_pin|
  step "I enter pin #{_pin}"
  step "I sign on canvas" if _condition != "invalid"
end

### fsu hack quick fix because of difference in zone setup across SIT and AUTO
Then (/^I sign on canvas with (invalid|valid) (.*) pin for fsu$/) do |_condition,_pin|
  step "I enter pin #{_pin}"
  on(SignaturePage).sign_and_done_fsu if _condition != "invalid"
end

Then (/^I sign on canvas only with valid (.*) pin$/) do |_pin|
  # step 'I sleep for 1 seconds'
  BrowserActions.poll_exists_and_click(on(CommonFormsPage).sign_btn_elements.first)
  # on(CommonFormsPage).sign_btn_elements.first.click
  step "I enter pin #{_pin}"
  on(SignaturePage).sign_for_gas
end

And (/^I wait for pinpad element to exists$/) do
  p "polling...."
  sleep 1
  if on(PinPadPage).pin_pad_elements.size === 0 
    step 'I wait for pinpad element to exists'
  end
end

And ('I enter pin {int}') do |pin|
  @@entered_pin = pin
  step 'I wait for pinpad element to exists'
  on(PinPadPage).enter_pin(pin)
  sleep 1
end

And(/^I enter pin for rank (.*)$/) do |rank|
  @@entered_pin = $sit_rank_and_pin_yml["sit_auto_rank"][rank] if $current_environment === "sit"
  @@entered_pin = $sit_rank_and_pin_yml["uat_rank"][rank] if $current_environment === "uat"
  p "pin: #{@@entered_pin}"
  step "I enter pin #{@@entered_pin.to_i}"
  sleep 1
end

When (/^I select (.+) permit$/) do |_permit|
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  on(Section0Page).select_level1_permit(_permit)
end

When (/^I select (.+) permit for level 2$/) do |_permit|
  @via_service_or_not = false
  on(Section0Page).select_level2_permit_and_next(_permit)
  ### TO remove UAT adaptation after UAT switch to 2.0
  if $current_environment === "sit"
    BrowserActions.wait_until_is_visible(on(Section0Page).ptw_id_element)
    @temp_id = on(Section0Page).ptw_id_element.text
  elsif $current_environment === "uat"
    BrowserActions.wait_until_is_visible(on(Section0Page).uat_ptw_id_element)
    @temp_id = on(Section0Page).uat_ptw_id_element.text
  end
  
end

And (/^I set permit id$/) do
  sleep 10
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

Given (/^I launch sol-x portal dashboard$/) do
  if ENV['ENVIRONMENT'] === 'sit'
    $browser.get(EnvironmentSelector.get_environment_url + "/dashboard")
  elsif ENV['ENVIRONMENT'] === 'auto'
    $browser.get(EnvironmentSelector.get_environment_url + "dashboard")
  else
    raise "Wrong Environment"
  end
    BrowserActions.wait_condition(20, on(CommonFormsPage).is_dashboard_screen_element.visible?)
  begin
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  rescue
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end