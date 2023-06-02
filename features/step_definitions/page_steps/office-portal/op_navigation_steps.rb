# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/op_navigation_page'

Given('OfficeNavigation navigate to the {string} page') do |page|
  @op_navigation_page ||= OPNavigationPage.new(@driver)
  @op_navigation_page.navigate_to_page(page)
end

Given('OfficeNavigation click "Back" arrow') do
  @op_navigation_page ||= OPNavigationPage.new(@driver)
  @op_navigation_page.click_back_arr
end

And('OfficeNavigation select {string} number of roles per page') do |option|
  @op_navigation_page ||= OPNavigationPage.new(@driver)
  @op_navigation_page.select_numbers(option)
end

And('OfficeNavigation select page number {string}') do |option|
  @op_navigation_page ||= OPNavigationPage.new(@driver)
  @op_navigation_page.select_num_page(option)
end

And('OfficeNavigation select {string} page') do |option|
  @op_navigation_page ||= OPNavigationPage.new(@driver)
  @op_navigation_page.switch_page(option)
end
