# frozen_string_literal: true

And(/^I should see entire hamburger categories$/) do
  on(NavigationPage).menu_categories_elements.each_with_index do |element, index|
    is_equal((on(NavigationPage).get_menu_categories)[index], element.text)
  end
end

And(/^I open hamburger menu$/) do
  BrowserActions.wait_until_is_visible(on(Section0Page).hamburger_menu_element)
  BrowserActions.wait_until_is_displayed(on(Section0Page).hamburger_menu_element)
  BrowserActions.poll_exists_and_click(on(NavigationPage).hamburger_menu_element)
end

And(/^I click on (.*) show more$/) do |which_category|
  on(NavigationPage).click_show_more(which_category)
end

Then(/^I navigate to "(.*)" screen for (.*)$/) do |which_section, which_category|
  sleep 1
  step 'I open hamburger menu'
  on(NavigationPage).select_nav_category(which_section, which_category)
  sleep 1
end

And(/^I click on back arrow$/) do
  BrowserActions.poll_exists_and_click(on(Section0Page).back_arrow_element)
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).permit_alert_element)
  rescue StandardError
  end
  step 'I set permit id' if CommonPage.get_permit_id.include? '/TEMP/'
end

And(/^I press (next|previous) for (.+) times$/) do |condition, times|
  on(NavigationPage).click_new_or_previous(condition, times)
end

And(/^I click on back to home$/) do
  on(NavigationPage).click_back_home
  begin
    BrowserActions.wait_until_is_visible(on(Section0Page).permit_alert_element)
  rescue StandardError
    sleep 5
  end
  step 'I set permit id' if CommonPage.get_permit_id.include? '/TEMP/'
end

And(/^I navigate to section (.+)$/) do |which_section|
  on(Section6Page).toggle_to_section(which_section)
end

And(/^I update permit in pending update state with (.*) rank$/) do |rank|
  step "I update permit with #{rank} rank"
end

And(/^I (.+) permit with (.+) rank$/) do |update_or_terminate, rank|
  sleep 1
  permit_id = on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)

  case update_or_terminate
  when 'add gas to'
    on(ActiveStatePage).add_gas_btn_elements[permit_id].click
  when 'update'
    BrowserActions.poll_exists_and_click(on(PendingStatePage).edit_update_btn_elements[permit_id])
  when 'view'
    @@issue_time_date = on(CreatedPermitToWorkPage).issued_date_time_elements[permit_id].text
    on(PendingStatePage).view_btn_elements[permit_id].click
  when 'review and withdraw'
    on(ActiveStatePage).terminate_permit_btn_elements[permit_id].click
  when 'withdraw'
    on(PendingWithdrawalPage).review_n_withdraw_elements[permit_id].click
  else
    raise "Wrong condition >>> #{update_or_terminate}"
  end
  step "I enter pin via service for rank #{rank}"
end

And('I take note of issued date and time') do
  @@issued_date_and_time = on(CreatedPermitToWorkPage)
                           .issued_date_time_elements[on(CreatedPermitToWorkPage)
                           .get_permit_index(CommonPage.get_permit_id)].text
end

And('I click New Entrant button on Enclose Space Entry PWT') do
  sleep 1
  permit_id = on(CreatedPermitToWorkPage).get_permit_index(CommonPage.get_permit_id)
  p "index >> #{permit_id}"
  on(ActiveStatePage).new_entrant_btn_elements[permit_id].click
  sleep 2
end

And('I click New Entry button on PTW screen') do
  BrowserActions.poll_exists_and_click(on(PreDisplay).new_entry_log_button)
  sleep 1
end

And(/^I click on (.*) tab$/) do |which_tab|
  case which_tab
  when 'entry log'
    BrowserActions.poll_exists_and_click(on(PreDisplay).entry_log_tab_element)
  when 'permit'
    BrowserActions.poll_exists_and_click(on(PreDisplay).permit_tab_element)
  else
    raise "Wrong condition >>> #{which_tab}"
  end
end

And(/^I go to (CRE|PRE|ESE) log in dashboard$/) do |condition|
  sleep 1
  BrowserActions.poll_exists_and_click(on(DashboardPage).entry_status_indicator_element)
  sleep 1
  if %w[PRE CRE].include?(condition)
    BrowserActions.poll_exists_and_click(on(DashboardPage).radio_button_enclosed_elements[0])
  end
  BrowserActions.poll_exists_and_click(on(DashboardPage).radio_button_enclosed_elements[1]) if condition == 'ESE'
end
