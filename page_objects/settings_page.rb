# frozen_string_literal: true

require_relative 'base_page'

# settings page object
class SettingPage < BasePage

  SETTINGS = {
    page_header: "//*[@id='root']/div/nav/header",
    pump_room_display_setting: "//span[contains(.,'Pump Room')]",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SETTINGS[:page_header])
  end

  def select_mode(permit_type)
    click(SETTINGS[:pump_room_display_setting]) if permit_type == 'PRE'
    click(SETTINGS[:compressor_room_display_setting]) if permit_type == 'CRE'
  end
end
