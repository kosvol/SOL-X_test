# frozen_string_literal: true

require_relative '../../../page_objects/navigation_drawer_page'


And('NavigationDrawer expand all menu items') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.expand_all_menu_items
end

And('NavigationDrawer verify hamburger categories') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.verify_base_menu
end

And('NavigationDrawer navigate to Permit to work {string}') do |page|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.navigate_to_ptw(page)
end

And('NavigationDrawer navigate to Compressor Motor Room {string}') do |page|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.navigate_to_entry(page)
end

And('NavigationDrawer navigate to Pump Room {string}') do |page|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.navigate_to_entry(page)
end

And('NavigationDrawer navigate to settings') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_settings_btn
end

And('NavigationDrawer click back arrow button') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_back_arrow
end

And('NavigationDrawer click go back button') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_go_back
end

And('NavigationDrawer click view button') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_view_button
end
