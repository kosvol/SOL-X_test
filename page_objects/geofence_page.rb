# frozen_string_literal: true

require_relative 'base_page'

# GeoFencePage object
class GeoFencePage < BasePage
  include EnvUtils

  GEOFENCE = {
    title: "//nav[starts-with(@class,'NavigationBar__NavBar-')]",
    cancel_btn: "//button[span='Cancel']"
  }.freeze

  def initialize(driver)
    super
    find_element(GEOFENCE[:title])
  end

  def click_cancel_btn
    click(GEOFENCE[:cancel_btn])
  end
end
