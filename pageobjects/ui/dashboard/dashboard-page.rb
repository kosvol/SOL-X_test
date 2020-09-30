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
  spans(:area_count, xpath: "//span[@class='count']")
  spans(:permits_count, xpath: '//span[@class="stat"]')
  div(:location_pin_txt, xpath: "//a[@data-testid='location-pin']/div")

  @@activity_indicator = '//table/tbody/tr/td/div'
  @@location_pin = "//a[@data-testid='location-pin']"

  def get_location_pin_text(location)
    toggle_zone_filter(location)
    begin
      location_pin_txt
    rescue StandardError
      false
    end
  end

  def unlink_all_crew_frm_wearable
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      next if wearable['crewMember'].nil?

      WearablePage.set_wearable_id(wearable['_id'])
      WearablePage.swap_payload('wearable-simulator/mod-unlink-crew-to-wearable')
      ServiceUtil.post_graph_ql('wearable-simulator/mod-unlink-crew-to-wearable')
    end
  end

  ### "rgba(67, 160, 71, 1), 1)" - green
  ### "rgba(242, 204, 84, 1)" - yellow
  def is_activity_indicator_status(color)
    # toggle_crew_activity_list
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

  def get_map_zone_count(which_zone)
    sleep 1
    exit if !area_count_elements[0].text === 1
    toggle_zone_filter(which_zone)
    case which_zone
    when 'Full Ship'
      area_count_elements[0].text
    when 'Engine Room'
      area_count_elements[1].text
    when 'Pump Room'
      area_count_elements[2].text
    when 'Funnel Stack'
      area_count_elements[3].text
    when 'Main Deck'
      area_count_elements[4].text
    when 'Lower Accomm.'
      area_count_elements[5].text
    when 'Nav. Bridge'
      area_count_elements[7].text
    end
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

  private

  def get_beacon_location
    @@list_of_beacon.each do |beacon|
      return beacon[1] if beacon.first === @@beacon.first
    end
  end

  def toggle_zone_filter(which_zone)
    case which_zone
    when 'Full Ship'
      area_count_elements[0].click
    when 'Engine Room'
      area_count_elements[1].click
    when 'Pump Room'
      area_count_elements[2].click
    when 'Funnel Stack'
      area_count_elements[3].click
    when 'Main Deck'
      area_count_elements[4].click
    when 'Accomm.'
      area_count_elements[5].click
    when 'Nav. Bridge'
      area_count_elements[6].click
    end
  end
end
