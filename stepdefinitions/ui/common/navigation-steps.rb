And (/^I should see entire hamburger categories$/) do
  on(NavigationPage).menu_categories_elements.each_with_index do |_element,_index|
    is_equal((on(NavigationPage).get_menu_categories)[_index],_element.text)
  end
end

And (/^I open hamburger menu$/) do
  BrowserActions.poll_exists_and_click(on(NavigationPage).hamburger_menu_element)
  # sleep 1
  # on(NavigationPage).hamburger_menu_element.click
end

And (/^I click on (.*) show more$/) do |_which_category|
  on(NavigationPage).click_show_more(_which_category)
end

Then (/^I navigate to "(.*)" screen for (.*)$/) do |_which_section,_which_category|
  step 'I open hamburger menu'
  on(NavigationPage).select_nav_category(_which_section,_which_category)
  sleep 1
end

And (/^I click on back arrow$/) do
  # sleep 1
  BrowserActions.poll_exists_and_click(on(Section0Page).back_arrow_element)
  # on(Section0Page).back_arrow_element.click
  sleep 5
  step 'I set permit id'
end

And (/^I press (next|previous) for (.+) times$/) do |_condition, _times|
  sleep 1
  (1.._times.to_i).each do |_i|
    _condition === 'next' ? on(Section0Page).click_next : on(CommonFormsPage).previous_btn_elements.first.click
    sleep 1
  end
end

And (/^I click on back to home$/) do
  sleep 2
  on(Section6Page).back_to_home_btn
  sleep 4
  step 'I set permit id'
end

And (/^I navigate to section (.+)$/) do |_which_section|
  on(Section6Page).toggle_to_section(_which_section)
end