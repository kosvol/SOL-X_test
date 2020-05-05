require './././support/env'

class DashboardPage
  include PageObject
  
  @root_xpath = "//%s[@data-testid='%s']"
  span(:inactive_status,xpath: "#{@root_xpath % ["span","inactive-status"]}")
  span(:active_status,xpath: "#{@root_xpath % ["span","active-status"]}")
  divs(:active_crew_details,xpath: "#{@root_xpath % ["div","crew-row"]}")
  element(:active_switch,xpath: "#{@root_xpath % ["div","status-toggle"]}/label")
  span(:last_seen,xpath: "#{@root_xpath % ["div","crew-row"]}/span[3]")
  spans(:area_count,xpath: "#{@root_xpath % ["div","area-buttons"]}/div/div/button/span[1]")
  
  @@activity_indicator = "//div[@data-testid='crew-row']/div/div"
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
  
  def is_activity_indicator_green(color)
    toggle_crew_activity_list
    color == "rgba(250, 173, 20, 1)" ? (sleep 27) : (sleep 23)
    $browser.find_element(:xpath, "#{@@activity_indicator}").css_value("background-color").to_s === color
    $browser.find_element(:xpath, "#{@@location_pin}").css_value("background-color").to_s === color
  end
  
  def get_inactive_crew_status
    inactive_status
  end
  
  def get_active_crew_status
    active_status
  end
  
  def get_serv_active_crew_count
    active_crew_count = 0
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      active_crew_count += 1 if !wearable['crewMember'].nil?
    end
    return active_crew_count
  end
  
  def is_crew_location_detail_correct(ui_or_service)
    ui_or_service === "ui" ? tmp = get_ui_active_crew_details : tmp = get_serv_active_crew_details
    Log.instance.info("\n\n#{tmp}")
    get_active_crew_details.each do |crew|
      Log.instance.info("\n\n#{crew}")
      return true if tmp.include? crew
    end
  end
  
  def toggle_crew_activity_list
    active_switch_element.click
  end

  def is_last_seen
    toggle_crew_activity_list
    last_seen
  end
  
  def get_map_zone_count(which_zone)
    toggle_crew_activity_list
    exit if !area_count_elements[0].text === 1
    case which_zone
    when "Engine Room"
      return area_count_elements[1].text
    when "Pump Room"
      return area_count_elements[2].text
    when "Funnel Stack"
      return area_count_elements[3].text
    when "Upper Deck"
      return area_count_elements[4].text
    when "Accomm."
      return area_count_elements[5].text
    when "Nav. Bridge"
      return area_count_elements[6].text
    end
  end
  
  private
  
  def get_active_crew_details
    crew_details = []
    active_crew_details_elements.each do |crew|
      tmp = crew.text.split(/\n/)
      tmp.pop()
      crew_details << tmp
    end
    return crew_details
  end
  
  def get_serv_active_crew_details
    crew_details = []
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      if !wearable['crewMember'].nil?
        crew_details << [wearable["crewMember"]["rank"],wearable["crewMember"]["lastName"],get_beacon_location]
      end
    end
    return crew_details
  end

  def get_ui_active_crew_details
    crew_details = []
    ServiceUtil.get_response_body['data']['wearables'].each do |wearable|
      if !wearable['crewMember'].nil?
        crew_details << [wearable["crewMember"]["rank"],wearable["crewMember"]["lastName"],"Pump Room 3rd Deck"]
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