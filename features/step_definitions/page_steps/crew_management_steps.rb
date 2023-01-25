# frozen_string_literal: true

require_relative '../../../page_objects/crew_management_page'

Given('CrewManagement verify the elements are available') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_elements
end

Given('CrewManagement compare crew count summary with crew list') do
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

Given('CrewManagement compare crew count UI with DB') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.compare_crew_qnt_ui_db
end

Then('CrewManagement verify crew member data') do |table|
  params = table.hashes.first
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.compare_ui_api_data(params['rank'])
end