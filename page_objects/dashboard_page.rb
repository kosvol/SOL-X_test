# frozen_string_literal: true

require_relative 'base_page'

# DashboardPage object
class DashboardPage < BasePage
  include EnvUtils
  attr_accessor :date_and_time

  DASHBOARD = {
    hamburger_menu_btn: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button",
    entry_status: "//span[starts-with(@class, 'EntryStatusIndicator__Status')]",
    gas_reading_change_screen: '//div[@aria-label="gas reading change"]',
    accept_new_reading_btn: "//span[contains(.,'Accept New Reading')]",
    terminate_current_permit_btn: '//span[contains(.,"Terminate Current Permit")]',
    gas_reading_change_close: '//button[@aria-label="Close"]',
    acknowledge_btn: "//button[contains(.,'Acknowledge')]",
    loading_screen: "//*[starts-with(@class,'SplashScreen__LoadingIndicator')]",
    create_geofence: "//button[span='Create GeoFence']",
    time_button: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/section/button",
    popup: "//h3[contains(., 'Local time changed')]",
    vessel_time: "//time[starts-with(@class,'Clock__Clock')]"
  }.freeze

  def open_page
    @driver.get("#{retrieve_env_url}/dashboard")
    wait_for_loading
  end

  def verify_gas_reader_alert
    find_element(DASHBOARD[:gas_reading_change_screen])
    find_element(DASHBOARD[:accept_new_reading_btn])
    find_element(DASHBOARD[:terminate_current_permit_btn])
    find_element(DASHBOARD[:gas_reading_change_close])
  end

  def accept_new_reading
    sleep 1
    click(DASHBOARD[:accept_new_reading_btn])
  end

  def terminate_current_permit
    sleep 1
    click(DASHBOARD[:terminate_current_permit_btn])
  end

  def close_gas_reading_change
    sleep 1
    click(DASHBOARD[:gas_reading_change_close])
  end

  def acknowledge_gas_change
    sleep 1
    click(DASHBOARD[:acknowledge_btn])
  end

  def verify_entry_status(entry_status)
    retry_count = 0
    until retrieve_text(DASHBOARD[:entry_status]) == entry_status
      @logger.debug("expected dashboard status #{entry_status},
current status #{retrieve_text(DASHBOARD[:entry_status])} retrying #{retry_count} times")
      retry_count += 1
      @driver.navigate.refresh
      sleep 2
      raise "dashboard entry status is wrong after #{retry_count} retries" if retry_count > 10
    end
  end

  def click_create_geofence
    click(DASHBOARD[:create_geofence])
  end

  def click_time_button
    click(DASHBOARD[:time_button])
  end

  def verify_popup
    find_element(DASHBOARD[:popup])
  end

  def retrieve_vessel_time
    retrieve_text(DASHBOARD[:vessel_time])
  end

  def verify_time_with_server
    time_server = TimeService.new.retrieve_ship_time_hh_mm
    time_ship = retrieve_vessel_time
    wait = 0
    while time_ship.to_s != time_server.to_s
      @logger.debug "wait for local time to be updated, retrying: #{wait} times"
      # sleep 0.5
      wait += 1
      time_ship = retrieve_vessel_time
      time_server = TimeService.new.retrieve_ship_time_hh_mm
      raise 'time out waiting for loading' if wait > 30
    end
  end

  private

  def wait_for_loading
    sleep 1
    wait = 0
    until @driver.find_elements(:xpath, DASHBOARD[:loading_screen]).size.zero?
      @logger.debug "wait for loading screen, retrying: #{wait} times"
      sleep 0.5
      wait += 1
      raise 'time out waiting for loading screen' if wait > 30
    end
  end
end
