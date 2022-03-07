# frozen_string_literal: true

require_relative 'base_page'

# DashboardEntryLogPage object
class DashboardEntryLogPage < BasePage
  include EnvUtils

  DASHBOARD_ENTRY_LOG = {
    page_header: "//h1[contains(.,'Entry Log')]",
    radio_button_enclosed: "//label[starts-with(@class,'RadioButton__RadioLabel')]"
  }.freeze

  def initialize(driver)
    super
    find_element(DASHBOARD_ENTRY_LOG[:page_header])
  end

  def select_entry_log_tab(condition)
    if %w[PRE CRE].include?(condition)
      find_elements(DASHBOARD_ENTRY_LOG[:radio_button_enclosed])[0].click
    else
      find_elements(DASHBOARD_ENTRY_LOG[:radio_button_enclosed])[1].click
    end
  end
end
