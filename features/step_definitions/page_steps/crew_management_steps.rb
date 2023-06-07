# frozen_string_literal: true

require_relative '../../../page_objects/crew_management_page'

Given('CrewManagement verify the elements are available') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_elements
end

Given('CrewManagement verify the crew list are loaded') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.wait_crew_table
end

Given('CrewManagement compare crew count') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.compare_crew_count
end

Given('CrewManagement click View PINs button') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.click_view_pin
end

Given('CrewManagement verify the count down timer') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_timer
end

Given('CrewManagement verify the PIN is {string}') do |option|
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_pin_availability(option)
end

Then('CrewManagement verify crew member data') do |table|
  params = table.hashes.first
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.compare_ui_api_data(params['rank'])
end

Given('CrewManagement verify the indicator') do |table|
  params = table.hashes.first
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_indicator(params['rank'], params['color'])
end

Given('CrewManagement verify location interval') do |table|
  params = table.hashes.first
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_interval(params['rank'], params['time'])
end

Given('CrewManagement verify crew list sorting') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_crew_list_sort
end

Given('CrewManagement open Add Crew window') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.open_add_crew_window
end

Given('CrewManagement verify button availability') do |table|
  @crew_management_page ||= CrewManagementPage.new(@driver)
  params = table.hashes.first
  @crew_management_page.verify_button(params['button'], params['availability'])
end
