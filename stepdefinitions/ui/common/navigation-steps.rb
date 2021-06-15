And (/^I should see entire hamburger categories$/) do
  on(NavigationPage).menu_categories_elements.each_with_index do |_element,_index|
    is_equal((on(NavigationPage).get_menu_categories)[_index],_element.text)
  end
end

And (/^I open hamburger menu$/) do
  BrowserActions.wait_condition(20, on(NavigationPage).hamburger_menu_element.enabled?)
  BrowserActions.poll_exists_and_click(on(NavigationPage).hamburger_menu_element)
end

And (/^I click on (.*) show more$/) do |_which_category|
  on(NavigationPage).click_show_more(_which_category)
end

Then (/^I navigate to "(.*)" screen for (.*)$/) do |_which_section,_which_category|
  sleep 1
  step 'I open hamburger menu'
  on(NavigationPage).select_nav_category(_which_section,_which_category)
  sleep 1
end

And (/^I click on back arrow$/) do
  BrowserActions.poll_exists_and_click(on(Section0Page).back_arrow_element)
  step 'I set permit id'
end

And (/^I press (next|previous) for (.+) times$/) do |_condition, _times|
  sleep 1
  (1.._times.to_i).each do |_i|
    if _condition === 'next'
      is_enabled(on(NavigationPage).next_btn_element)
      on(Section0Page).click_next
    else BrowserActions.js_click("//button[contains(.,'Previous')]")
    end
  end
end

And (/^I click on back to home$/) do
  # sleep 1
  BrowserActions.poll_exists_and_click(on(Section6Page).back_to_home_btn_element)
  # BrowserActions.js_click("//button[contains(.,'Back to Home')]")
  # on(Section6Page).back_to_home_btn
  step 'I set permit id'
end

And (/^I navigate to section (.+)$/) do |_which_section|
  on(Section6Page).toggle_to_section(_which_section)
end

And (/^I update permit in pending update state with (.*) pin$/) do |_pin|
  step "I update permit with A/M rank and #{_pin} pin"
end

And (/^I (.+) permit with (.+) rank and (.*) pin$/) do |_update_or_terminate, _rank, _pin|
  sleep 1
  permit_id = on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)
  p "index >> #{permit_id}"

  if _update_or_terminate === 'add gas to'
    on(ActiveStatePage).add_gas_btn_elements[permit_id].click
  elsif _update_or_terminate === 'update'
    # on(PendingStatePage).edit_update_btn_elements.first.click
    on(PendingStatePage).edit_update_btn_elements[permit_id].click
  elsif _update_or_terminate === 'view'
    @@issue_time_date = on(CreatedPermitToWorkPage).issued_date_time_elements[permit_id].text
    on(PendingStatePage).view_btn_elements[permit_id].click
  elsif _update_or_terminate === 'withdraw'
    on(PendingWithdrawalPage).review_n_withdraw_elements[permit_id].click
  elsif _update_or_terminate === 'terminate'
    step 'I click on Submit for Termination'
  end
  # sleep 1
  step "I enter pin #{_pin}"
end

And ('I take note of issued date and time') do
  @@issued_date_and_time = on(CreatedPermitToWorkPage).issued_date_time_elements[on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)].text
end

And ('I click New Entrant button on Enclose Space Entry PWT') do
  sleep 1
  permit_id = on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)
  p "index >> #{permit_id}"
  on(ActiveStatePage).new_entrant_btn_elements[permit_id].click
  sleep 2
end

And ('I click New Entry button on PTW screen') do
  BrowserActions.poll_exists_and_click(on(PreDisplay).new_entry_log_button)
  sleep 1
end

And (/^I click on (.*) tab$/) do |_which_tab|
  sleep 5
  case _which_tab
  when 'entry log'
    BrowserActions.poll_exists_and_click(on(PreDisplay).entry_log_tab_element)
  when 'permit'
    BrowserActions.poll_exists_and_click(on(PreDisplay).permit_tab_element)
  end
end

And (/^I go to ESE log in dashboard$/) do
  sleep 1
  BrowserActions.poll_exists_and_click(on(DashboardPage).entry_status_indicator_element)
  sleep 1
  BrowserActions.poll_exists_and_click(on(DashboardPage).radio_button_enclosed_elements[0])
  #on(DashboardPage).radio_button_enclosed_elements[1].click
end

And (/^I go to CRE log in dashboard$/) do
  sleep 1
  BrowserActions.poll_exists_and_click(on(DashboardPage).entry_status_indicator_element)
  sleep 1
  BrowserActions.poll_exists_and_click(on(DashboardPage).radio_button_enclosed_elements[0])
  #on(DashboardPage).radio_button_enclosed_elements[0].click
end