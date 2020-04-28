Given (/^I launch sol-x portal$/) do
  $browser.get(EnvironmentSelector.get_environment_url)
end

When (/^I navigate to crew list screen$/) do |which_section|
  on(NavigationPage).tap_hamburger_menu
  on(NavigationPage).select_nav_section(which_section)
end 

Then (/^I should see crew details display correctly$/) do
end 

And (/^I should see table header display correctly$/) do
end