# frozen_string_literal: true

require_relative 'base_page'

# SmartFormsPage object
class SmartFormsPage < BasePage
  include EnvUtils

  SMART_FORMS = {
    click_create_permit_btn: "//button[contains(.,'Create Permit To Work')]",
    create_new_pre_btn: "//span[contains(.,'Pump Room')]",
    create_new_cre_btn: "//span[contains(.,'Compressor/Motor')]"
  }.freeze

  def open_page
    @driver.get(retrieve_env_url)
  end

  def click_create_permit_to_work
    click(SMART_FORMS[:click_create_permit_btn])
  end

  def click_create_new_pre_btn
    click(SMART_FORMS[:create_new_pre_btn])
  end

  def click_create_new_cre_btn
    click(SMART_FORMS[:create_new_cre_btn])
  end

end
