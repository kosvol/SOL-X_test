require_relative '../../../page_objects/navigation_drawer_page'


And('NavigationDrawer click show more on {string}') do |category|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_show_more_btn(category)
end

And('NavigationDrawer open hamburger menu') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_hamburger_menu_btn
end

And('NavigationDrawer verify hamburger categories') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.verify_base_menu
end

And('NavigationDrawer navigate to Permit to work {string}') do |page|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_hamburger_menu_btn
  @navigation_drawer_page.navigate_to_ptw(page)
end

And('NavigationDrawer navigate to Compressor Motor Room {string}') do |page|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_hamburger_menu_btn
  @navigation_drawer_page.navigate_to_entry(page)
end

And('NavigationDrawer navigate to Pump Room {string}') do |page|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_hamburger_menu_btn
  @navigation_drawer_page.navigate_to_entry(page)
end

And('NavigationDrawer navigate to settings') do
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.click_hamburger_menu_btn
  @navigation_drawer_page.select_settings_cat
end

And('NavigationDrawer navigate to {string} display until see active permit') do |permit_type|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.navigate_until_active_ptw(permit_type)
end

And('NavigationDrawer navigate to {string} display') do |permit_type|
  @navigation_drawer_page ||= NavigationDrawerPage.new(@driver)
  @navigation_drawer_page.navigate_to_display_page(permit_type)
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
