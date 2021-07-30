# frozen_string_literal: true

And(/^I turn (off|on) wifi$/) do |_on_or_off|
  BrowserActions.turn_wifi_off_on
end

Given(/^I launch sol-x portal$/) do
  step 'I unlink all crew from wearable'
  $browser.get(EnvironmentSelector.get_environment_url)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  rescue StandardError
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end

Given(/^I launch sol-x portal without unlinking wearable$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
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

Then(/^I sign with (invalid|valid) (.*) rank$/) do |_condition, _rank|
  step "I enter pin for rank #{_rank}" ($current_environment.include? 'sit') || ($current_environment.include? 'auto')
  step "I enter pin via service for rank #{_rank}" if $current_environment === 'uat'
  step 'I sign on canvas' if _condition != 'invalid'
end

# ### fsu hack quick fix because of difference in zone setup across SIT and AUTO
# Then(/^i sign with (invalid|valid) (.*) rank for fsu$/) do |_condition, _rank|
#   step "I enter pin for rank #{_rank}" ($current_environment.include? 'sit') || ($current_environment.include? 'auto')
#   step 'I enter pin via service for rank C/O' if $current_environment === 'uat'
#   on(SignaturePage).sign_and_done_fsu if _condition != 'invalid'
# end

And('I enter pin {int}') do |pin|
  CommonPage.set_entered_pin = pin
  sleep 1
  on(PinPadPage).enter_pin(CommonPage.get_entered_pin.to_s)
end

And(/^I enter pin via service for rank (.*)$/) do |rank|
  step 'I get pinpad/get-pin-by-role request payload'
  step 'I hit graphql'
  ServiceUtil.get_response_body['data']['users'].each do |_crew|
    if _crew['crewMember']['rank'] === rank
      step "I enter pin #{_crew['pin'].to_i}"
      break
    else
      CommonPage.set_entered_pin = nil
    end
  end
end

And(/^I enter pin for rank (.*)$/) do |rank|
  if ($current_environment.include? 'sit') || ($current_environment.include? 'auto')
    CommonPage.set_entered_pin = $sit_rank_and_pin_yml['sit_auto_rank'][rank]
  end
  CommonPage.set_entered_pin = $sit_rank_and_pin_yml['uat_rank'][rank] if $current_environment === 'uat'
  sleep 1
  step "I enter pin #{(CommonPage.get_entered_pin.to_i)}"
end

When(/^I select (.+) permit$/) do |_permit|
  BrowserActions.poll_exists_and_click(on(Section0Page).click_permit_type_ddl_element)
  on(Section0Page).select_level1_permit(_permit)
end

When(/^I select (.+) permit for level 2$/) do |_permit|
  @via_service_or_not = false
  sleep 1
  on(Section0Page).select_level2_permit_and_next(_permit)
  ### TO remove UAT adaptation after UAT switch to 2.0
  ($current_environment.include? 'sit') || ($current_environment.include? 'auto')
    BrowserActions.wait_until_is_visible(on(Section0Page).ptw_id_element)
    @temp_id = on(Section0Page).ptw_id_element.text
  elsif $current_environment === 'uat'
    BrowserActions.wait_until_is_visible(on(Section0Page).uat_ptw_id_element)
    @temp_id = on(Section0Page).uat_ptw_id_element.text
  end
end

And(/^I set permit id$/) do
  if @via_service_or_not === false
    Log.instance.info("Temp ID >> #{@temp_id}")
    CommonPage.set_permit_id(WorkWithIndexeddb.get_id_from_indexeddb(@temp_id))
  end
  sleep 5
end

And(/^I set time$/) do
  on(CommonFormsPage).set_current_time
end

Given(/^I launch sol-x portal dashboard$/) do
  if $current_environment === 'sit'
    $browser.get(EnvironmentSelector.get_environment_url + '/dashboard')
  elsif $current_environment === 'auto'
    $browser.get(EnvironmentSelector.get_environment_url + 'dashboard')
  else
    raise 'Wrong Environment'
  end
  BrowserActions.wait_condition(20, on(CommonFormsPage).is_dashboard_screen_element.visible?)
  begin
    BrowserActions.wait_until_is_visible(on(CommonFormsPage).is_dashboard_screen_element)
  rescue StandardError
    BrowserActions.wait_until_is_visible(on(Section0Page).click_create_permit_btn_element)
  end
  # sleep 5
  # puts "screen size: #{$browser.window_size}"
end
