# frozen_string_literal: true

And(/^I turn (off|on) wifi$/) do |_on_or_off|
  BrowserActions.turn_wifi_off_on
end

Given(/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  $browser.get(EnvironmentSelector.environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue StandardError
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end

Given(/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue StandardError
    begin
      BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
    rescue StandardError
      BrowserActions.wait_until_is_visible(on(Section0Page).uat_create_permit_btn_element)
    end
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end

And('I sleep for {int} seconds') do |sec|
  sleep sec
end

And(/^I sign on canvas$/) do
  on(SignaturePage).sign_and_done
end

Then(/^I sign with (invalid|valid) (.*) rank$/) do |condition, rank|
  step "I enter pin via service for rank #{rank}"
  step 'I sign on canvas' if condition != 'invalid'
end

And(/^I enter pure pin (.*)$/) do |pin|
  CommonPage.set_entered_pin = pin
  sleep 1
  on(PinPadPage).enter_pin(CommonPage.get_entered_pin)
end

And(/^I enter pin via service for rank (.*)$/) do |rank|
  step 'I get pinpad/get-pin-by-role request payload'
  step 'I hit graphql'
  ServiceUtil.get_response_body['data']['users'].each do |crew|
    if crew['crewMember']['rank'] == rank
      step "I enter pure pin #{crew['pin']}"
      break
    else
      CommonPage.set_entered_pin = nil
    end
  end
end

And(/^I enter pin for rank (.*)$/) do |rank|
  if (EnvironmentSelector.current_environment.include? 'sit') || (EnvironmentSelector.current_environment.include? 'auto')
    CommonPage.set_entered_pin = $sit_rank_and_pin_yml['sit_auto_rank'][rank]
  end
  sleep 1
  step "I enter pure pin #{CommonPage.get_entered_pin}"
end

When(/^I select (.+) permit$/) do |permit|
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  on(Section0Page).select_level1_permit(permit)
end

When(/^I select (.+) permit for level 2$/) do |permit|
  @via_service_or_not = false
  on(Section0Page).select_level2_permit_and_next(permit)
  BrowserActions.wait_until_is_visible(on(Section0Page).ptw_id_element)
  @get_permit_creation_datetime = on(CommonFormsPage).get_current_date_and_time
end

And(/^I set permit id$/) do
  if @via_service_or_not == false
    Log.instance.info("Temp ID >> #{CommonPage.get_permit_id}")
    CommonPage.set_permit_id(WorkWithIndexeddb.get_id_from_indexeddb(CommonPage.get_permit_id))
    Log.instance.info "New Permit ID: #{CommonPage.get_permit_id}"
  end
end

And(/^I set time$/) do
  on(CommonFormsPage).set_current_time
end

Given(/^I launch sol-x portal dashboard$/) do
  $browser.get("#{EnvironmentSelector.environment_url}dashboard")
  begin
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  rescue StandardError
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end
