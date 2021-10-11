# frozen_string_literal: true

require './././support/env'

class DashboardPage < WearablePage
  include PageObject

  elements(:crew_list_headers, xpath: '//th')
  element(:permit_to_work, xpath: '//table/tbody/tr/td[4]') # same as below
  elements(:permit_to_work_link, xpath: '//td/ul/li/a') # same as above
  elements(:active_crew_details, xpath: '//table/tbody/tr')
  elements(:crew_list, xpath: '//table/tbody/tr')
  element(:active_switch, xpath: "//label[starts-with(@class,'ToggleSwitch__Switch')]")
  element(:last_seen, xpath: '//table/tbody/tr/td[5]')
  spans(:permits_count, xpath: '//span[@class="stat"]')
  span(:location_pin_txt,
       xpath: "//button[@data-testid='location-pin']/div[starts-with(@class, 'Pin__MarkerPin')]/span")
  button(:area_dd, xpath: "//div[starts-with(@class,'values-area')]/button")
  span(:pre_indicator, xpath: "//span[starts-with(@class,'EntryStatusIndicator__Status')]")
  element(:entry_status_indicator, xpath: "//div[starts-with(@class,'ActiveEntrantIndicator__ButtonContent')]")
  elements(:radio_button_enclosed, xpath: "//label[starts-with(@class,'RadioButton__RadioLabel')]")
  element(:entry_log_title, xpath: "//div[starts-with(@class,'EntryLogDisplay__EntryLogs')]/h2")
  element(:active_entrant, xpath: "//span[@data-testid='entrant-count']")
  @@ship_area = "//button[contains(.,'%s')]"
  # Gas reading alert
  element(:gas_alert, xpath: "//div[starts-with(@class,'GasReaderAlert')]")
  element(:gas_alert_accept_new, xpath: "//span[starts-with(@class,'Button__Button')][0]")
  element(:gas_alert_discard_new, xpath: '//button[contains(.,"Terminate Current Permit")]')
  @@pre_indicator = "//span[starts-with(@class,'EntryStatusIndicator__Status')]"

  @@activity_indicator = '//table/tbody/tr/td/div'
  @@location_pin = "//button[@data-testid='location-pin']/div[starts-with(@class, 'Pin__MarkerPin')]" # "//a[@data-testid='location-pin']"
  @@arr_data = []

  # Gas reading alert
  element(:gas_alert, css: "div[data-testid='gas-reader-alert'] > div > section > h2")
  element(:gas_alert_accept_new, xpath: "//span[contains(.,'Accept New Reading')]")
  element(:gas_alert_discard_new, xpath: '//span[contains(.,"Terminate Current Permit")]')
  element(:gas_close_btn, css: "button[aria-label='Close']")
  element(:pre_cre_title_indicator, xpath: "//h3[contains(@class,'EntryStatusIndicator__Title')]")

  def set_arr_data(data)
    @@arr_data.push(data)
  end

  def get_arr_data
    @@arr_data
  end

  def is_pre_indicator_color?(condition)
    tmp = @browser.find_element(:xpath, @@pre_indicator.to_s)
    tmp.css_value('color').to_s == if condition.downcase == 'active'
                                     'rgba(67, 160, 71, 1)'
                                   else
                                     'rgba(216, 75, 75, 1)'
                                   end
  end

  def get_location_pin_text(_location)
    @browser.find_elements(:xpath, '//div/button/span')[2].click
    begin
      location_pin_txt
    rescue StandardError
      false
    end
  end

  def unlink_all_crew_frm_wearable
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      next if wearable['userId'].nil?

      WearablePage.set_wearable_id(wearable['_id'])
      WearablePage.swap_payload('wearable-simulator/mod-unlink-crew-to-wearable')
      ServiceUtil.post_graph_ql('wearable-simulator/mod-unlink-crew-to-wearable')
    end
  end

  ### "rgba(67, 160, 71, 1), 1)" - green
  ### "rgba(242, 204, 84, 1)" - yellow
  def activity_indicator_status?(color)
    color == 'rgba(242, 204, 84, 1)' ? (sleep 297) : (sleep 150)
    @browser.find_element(:xpath, @@activity_indicator.to_s).css_value('background-color').to_s == color
    @browser.find_element(:xpath, @@location_pin.to_s).css_value('background-color').to_s == color
  end

  def is_crew_location_detail_correct?(ui_or_service, new_zone = nil)
    sleep 2
    tmp = get_active_crew_details(ui_or_service, new_zone).first
    get_ui_active_crew_details.all? do |crew|
      Log.instance.info("beacon >> \n\n#{tmp}")
      Log.instance.info("crew >> \n\n#{crew}")
      tmp == crew
    end
  end

  def toggle_crew_activity_list
    active_switch_element.click
  end

  def is_last_seen
    last_seen_element.text
  end

  def get_map_zone_count(which_zone, total_crew)
    expand_area_dd
    sleep 2
    xpath_str = format(@@ship_area, "#{which_zone} (#{total_crew})")
    @browser.find_element('xpath', xpath_str).text
  end

  def expand_area_dd
    area_dd
  end

  def dismiss_area_dd
    BrowserActions.js_click("//div[@data-testid='dropdown-overlay-container']")
  end

  def get_active_crew_details(ui_or_service, new_zone = nil)
    crew_details = []
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      next if wearable['crewMember'].nil?

      crew_details << if ui_or_service == 'service'
                        [wearable['crewMember']['rank'], wearable['crewMember']['lastName'], get_beacon_location, 'N/A']
                      else
                        [wearable['crewMember']['rank'], wearable['crewMember']['lastName'], new_zone, 'N/A']
                      end
    end
    crew_details
  end

  def get_ui_active_crew_details
    crew_details = []
    active_crew_details_elements.each do |crew|
      tmp = crew.text.split(/\n/)
      tmp.pop
      crew_details << tmp
    end
    crew_details
  end

  def toggle_zone_filter(which_zone)
    xpath_str = format(@@ship_area, which_zone)
    sleep 1
    @browser.find_element(:xpath, xpath_str.to_s).click
  end

  private

  def get_beacon_location
    @@list_of_beacon.each do |beacon|
      return beacon[1] if beacon.first == @@beacon.first
    end
  end
end