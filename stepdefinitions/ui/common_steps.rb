Given (/^I launch sol-x portal$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
  step 'I unlink all crew from wearable'
  sleep 2
end

When (/^I navigate to "(.+)" screen$/) do |which_section|
  on(NavigationPage).tap_hamburger_menu
  on(NavigationPage).select_nav_section(which_section)
end