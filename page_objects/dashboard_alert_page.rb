# frozen_string_literal: true

# require_relative '../service/utils/user_service'
require_relative 'base_page'

# SubmittedPage object
class DashboardAlertPage < BasePage
  DASHBOARD_ALERT = {
    main_header: "//h2[contains(.,'Attention Required')]",
    ca_rank: "//div[(@class = 'label')][contains(., 'Rank')]/following::*[contains(., '%s')]",
    ca_name: "/following::*[(@class = 'label')][contains(., 'Name')]/following::*[%s]",
    ca_location: "/following::*[(@class = 'label')][contains(., 'Location')]/following::*[%s]",
    ack_btn: "/following::*[span = 'Acknowledge']"
  }.freeze

  def click_acknowledge_button(rank)
    rank_path = format((DASHBOARD_ALERT[:ca_rank]), rank)
    click(rank_path + DASHBOARD_ALERT[:ack_btn])
  end

  def verify_alert_availability(text, option)
    verify_availability("//header[contains(., '#{text}')]", option)
  end

  def retrieve_ca_location_ui(rank)
    begin
      find_element(format(DASHBOARD_ALERT[:ca_rank], rank)).nil?
    rescue StandardError
      raise "There is no Alert from #{rank}"
    end
    rank_path = format((DASHBOARD_ALERT[:ca_rank]), rank)
    loc_path = format((DASHBOARD_ALERT[:ca_location]), 1)
    retrieve_text(rank_path + loc_path)
  end

  def retrieve_ca_name_ui(rank)
    rank_path = format((DASHBOARD_ALERT[:ca_rank]), rank)
    name_path = format((DASHBOARD_ALERT[:ca_name]), 1)
    retrieve_text(rank_path + name_path)
  end

  def retrieve_ca_location_api(rank)
    WearableService.new.crew_assist_retrieve_location(rank)
  end

  def retrieve_ca_name_api(rank)
    WearableService.new.crew_assist_retrieve_name(rank)
  end

  def compare_ui_api_ca_data(rank)
    zone_ui = retrieve_ca_location_ui(rank)
    zone_api = retrieve_ca_location_api(rank)
    name_ui = retrieve_ca_name_ui(rank)
    name_api = retrieve_ca_name_api(rank)
    @logger.debug "Location for the user #{rank} from UI: #{zone_ui} from API: #{zone_api}"
    @logger.debug "Name for the user #{rank} from UI: #{name_ui} from API: #{name_api}"
    raise 'The Data do not match' if zone_ui != zone_api || name_ui != name_api
  end

  private

  def verify_availability(xpath, option)
    case option
    when 'displayed'
      wait_alert_screen
      find_element(xpath).displayed?
    when 'not displayed'
      sleep 1.5
      verify_element_not_exist(xpath)
    else
      raise "unknown option - #{option}"
    end
  end

  def wait_alert_screen
    wait = Selenium::WebDriver::Wait.new(timeout: 20)
    wait.until { @driver.find_element(:xpath, DASHBOARD_ALERT[:main_header]).displayed? }
  rescue StandardError
    raise 'Time out waiting for Alert screen'
  end
end
