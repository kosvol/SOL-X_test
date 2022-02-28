# frozen_string_literal: true

require_relative 'base_page'

# SmartFormsPage object
class SmartFormsPage < BasePage
  include EnvUtils

  SMART_FORMS = {
    create_permit_btn: "//button[contains(.,'Create Permit To Work')]",
    create_new_pre_btn: "//span[contains(.,'Pump Room')]",
    create_new_cre_btn: "//span[contains(.,'Compressor/Motor')]",
    hamburger_menu_btn: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button",
    loading_screen: "//*[starts-with(@class,'SplashScreen__LoadingIndicator')]"
  }.freeze

  def open_page
    @driver.get(retrieve_env_url)
    wait_for_loading
    find_element(SMART_FORMS[:hamburger_menu_btn])
  end

  def open_state_page(state)
    @driver.get("#{retrieve_env_url}/forms/ptw/#{state}")
    wait_for_loading
  end

  def click_create_permit_to_work
    sleep 0.5 # monitor the performance
    click(SMART_FORMS[:create_permit_btn])
  end

  def click_create_new_pre_btn
    click(SMART_FORMS[:create_new_pre_btn])
  end

  def click_create_new_cre_btn
    click(SMART_FORMS[:create_new_cre_btn])
  end

  private

  def wait_for_loading
    wait = 0
    until @driver.find_elements(:xpath, SMART_FORMS[:loading_screen]).size.zero?
      @logger.debug "wait for loading screen, retrying: #{wait} times"
      sleep 0.5
      wait += 1
      raise 'time out waiting for loading screen' if wait > 30
    end
  end
end

