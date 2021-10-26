# frozen_string_literal: true

require_relative 'base_page'

# SmartFormsPage object
class SmartFormsPage < BasePage
  include EnvUtils

  SMART_FORMS = {
    click_create_permit_btn: "//button[contains(.,'Create Permit To Work')]"
  }.freeze

  def open_page
    @driver.get(retrieve_env_url)
  end

  def click_create_permit_to_work
    click(SMART_FORMS[:click_create_permit_btn])
  end
end
