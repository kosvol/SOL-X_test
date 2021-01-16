# frozen_string_literal: true

require './././support/env'

class DashboardPage < WearablePage
  include PageObject

  element(:inactive_status, xpath: "//label[@data-testid='inactive-status']")
  element(:active_status, xpath: "//label[@data-testid='active-status']")
  elements(:active_crew_details, xpath: '//table/tbody/tr')
  elements(:crew_list, xpath: '//table/tbody/tr')
  element(:active_switch, xpath: "//label[starts-with(@class,'CrewStatusToggle__Switch')]")
  element(:last_seen, xpath: '//table/tbody/tr/td[4]')
  spans(:permits_count, xpath: '//span[@class="stat"]')
  div(:location_pin_txt, xpath: "//a[@data-testid='location-pin']/div")
  button(:area_dd, xpath: "//div[starts-with(@class,'values-area')]/button")
  span(:pre_indicator, xpath: "//span[starts-with(@class,'PREIndicator__Status-')]")
  @@ship_area = "//li/button[contains(.,'%s')]"
  @@pre_indicator = "//span[starts-with(@class,'PREIndicator__Status-')]"

  @@activity_indicator = '//table/tbody/tr/td/div'
  @@location_pin = "//a[@data-testid='location-pin']"

  def is_pre_indicator_color?(_condition)
    tmp = $browser.find_element(:xpath, @@pre_indicator.to_s)
    if _condition.downcase === 'active'
      tmp.css_value('color').to_s === 'rgba(0, 112, 26, 1)'
    elsif _condition.downcase === 'inactive'
      tmp.css_value('color').to_s === 'rgba(104, 110, 119, 1)'
    end
  end

  def expand_ship_zones_dd
    @browser.execute_script(%(document.evaluate("//div[starts-with(@class,'values-area')]/button", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
  end

  def get_location_pin_text(location)
    sleep 1
    toggle_zone_filter(location)
    sleep 1
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
  def is_activity_indicator_status(color)
    color === 'rgba(242, 204, 84, 1)' ? (sleep 297) : (sleep 150)
    $browser.find_element(:xpath, @@activity_indicator.to_s).css_value('background-color').to_s === color
    $browser.find_element(:xpath, @@location_pin.to_s).css_value('background-color').to_s === color
  end

  def get_serv_active_crew_count
    active_crew_count = 0
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      active_crew_count += 1 unless wearable['crewMember'].nil?
    end
    active_crew_count
  end

  def is_crew_location_detail_correct?(ui_or_service, _new_zone = nil)
    sleep 2
    tmp = get_active_crew_details(ui_or_service, _new_zone)
    Log.instance.info("\n\n#{tmp}")
    get_ui_active_crew_details.all? do |crew|
      Log.instance.info("\n\n#{crew}")
      tmp.include? crew
    end
  end

  def toggle_crew_activity_list
    active_switch_element.click
  end

  def is_last_seen
    last_seen_element.text
  end

  def get_map_zone_count(which_zone, total_crew)
    area_dd
    sleep 1
    xpath_str = format(@@ship_area, "#{which_zone} (#{total_crew})")
    @browser.find_element('xpath', xpath_str).text
  end

  def get_active_crew_details(ui_or_service, _new_zone = nil)
    crew_details = []
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      unless wearable['crewMember'].nil?
        if ui_or_service === 'service'
          crew_details << [wearable['crewMember']['rank'] + ' ' + wearable['crewMember']['lastName'], get_beacon_location]
        elsif ui_or_service === 'ui'
          crew_details << [wearable['crewMember']['rank'] + ' ' + wearable['crewMember']['lastName'], _new_zone]
        end
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
    @browser.find_element('xpath', xpath_str).click
  end

  private

  def get_beacon_location
    @@list_of_beacon.each do |beacon|
      return beacon[1] if beacon.first === @@beacon.first
    end
  end
end
