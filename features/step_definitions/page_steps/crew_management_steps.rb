# frozen_string_literal: true

require_relative '../../../page_objects/crew_management_page'

Given('CrewManagement verify elements') do
  @crew_management_page ||= CrewManagementPage.new(@driver)
  @crew_management_page.verify_elements
end
