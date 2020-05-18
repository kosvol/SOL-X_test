require './././support/env'

class DashboardPage < WearablePage
  include PageObject
  
  span(:inactive_status,xpath: "//span[@data-testid='inactive-status']")
  span(:active_status,xpath: "//span[@data-testid='active-status']")
  elements(:active_crew_details,xpath: "//table/tbody/tr")
  elements(:crew_list,xpath: "//table/tbody/tr")
  element(:active_switch,xpath: "//div[@role='switch']/label")
  element(:last_seen,xpath: "//table/tbody/tr/td[4]")
  spans(:area_count,xpath: "//span[@class='count']")
  spans(:permits_count,xpath: '//span[@class="stat"]')
  
  @@activity_indicator = "//table/tbody/tr/td/div"
  @@location_pin = "//a[@data-testid='location-pin']"
  
  def unlink_all_crew_frm_wearable
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      if !wearable['crewMember'].nil?
        WearablePage.set_wearable_id(wearable['_id'])
        WearablePage.swap_payload("wearable-simulator/base-unlink-crew-to-wearable")
        ServiceUtil.post_graph_ql("wearable-simulator/base-unlink-crew-to-wearable")
      end
    end
  end
  
  
  ### "rgba(67, 160, 71, 1), 1)" - green
  ### "rgba(242, 204, 84, 1)" - yellow
  def is_activity_indicator_status(color)
    toggle_crew_activity_list
    color == "rgba(242, 204, 84, 1)" ? (sleep 27) : (sleep 2)
    $browser.find_element(:xpath, "#{@@activity_indicator}").css_value("background-color").to_s === color
    $browser.find_element(:xpath, "#{@@location_pin}").css_value("background-color").to_s === color
  end
  
  def get_serv_active_crew_count
    active_crew_count = 0
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      active_crew_count += 1 if !wearable['crewMember'].nil?
    end
    return active_crew_count
  end
  
  def is_crew_location_detail_correct(ui_or_service)
    tmp = get_serv_active_crew_details(ui_or_service)
    Log.instance.info("\n\n#{tmp}")
    get_ui_active_crew_details.each do |crew|
      Log.instance.info("\n\n#{crew}")
      return true if tmp.include? crew
    end
  end
  
  def toggle_crew_activity_list
    active_switch_element.click
  end

  def is_last_seen
    last_seen_element.text
  end
  
  def get_map_zone_count(which_zone)
    toggle_crew_activity_list
    exit if !area_count_elements[0].text === 1
    case which_zone
    when "Engine Room"
      area_count_elements[1].click
      return area_count_elements[1].text
    when "Pump Room"
      area_count_elements[2].click
      return area_count_elements[2].text
    when "Funnel Stack"
      area_count_elements[3].click
      return area_count_elements[3].text
    when "Upper Deck"
      area_count_elements[4].click
      return area_count_elements[4].text
    when "Accomm."
      area_count_elements[5].click
      return area_count_elements[5].text
    when "Nav. Bridge"
      area_count_elements[6].click
      return area_count_elements[6].text
    end
  end
  
  private
  
  def get_ui_active_crew_details
    crew_details = []
    active_crew_details_elements.each do |crew|
      tmp = crew.text.split(/\n/)
      tmp.pop()
      crew_details << tmp
    end
    return crew_details
  end
  
  def get_serv_active_crew_details(ui_or_service)
    crew_details = []
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      if !wearable['crewMember'].nil?
        if ui_or_service === "service"
        crew_details << [wearable["crewMember"]["rank"] +" "+ wearable["crewMember"]["lastName"],get_beacon_location]
        elsif ui_or_service === "ui"
          crew_details << [wearable["crewMember"]["rank"] +" "+ wearable["crewMember"]["lastName"],"Pump Room Bottom"]
        end
      end
    end
    return crew_details
  end
  
  def get_beacon_location
    @@list_of_beacon.each do |beacon|
      return beacon[1] if beacon.first === @@beacon.first
    end
  end
  
end