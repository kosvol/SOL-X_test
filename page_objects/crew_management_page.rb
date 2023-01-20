# frozen_string_literal: true

require_relative 'base_page'

# CrewManagementPage object
class CrewManagementPage < BasePage
  include EnvUtils

  CREW_MANAGEMENT = {
    header: "//h1[contains(., 'Crew Management')]",
  }.freeze

  def verify_elements
    find_element(CREW_MANAGEMENT[:header])
  end

end
