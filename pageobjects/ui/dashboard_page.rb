require './././support/env'

class DashboardPage < WearablePage
  include PageObject
  
  @root_xpath = "//%s[@data-testid='%s']"
  span(:inactive_status,xpath: "#{@root_xpath % ["span","inactive-status"]}")
  span(:active_status,xpath: "#{@root_xpath % ["span","active-status"]}")
  divs(:active_crew_details,xpath: "#{@root_xpath % ["div","crew-row"]}")
  element(:active_switch,xpath: "#{@root_xpath % ["div","status-toggle"]}/label")
  span(:last_seen,xpath: "#{@root_xpath % ["div","crew-row"]}/span[3]")
  @@activity_indicator = "//div[@data-testid='crew-row']/div/div"
  @@location_pin = "//a[@data-testid='location-pin']"
  # element(:location_pin,xpath: "#{@root_xpath % ["a","location-pin"]}")

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
    active_switch_element.click
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

  def is_crew_location_detail_correct
    tmp = get_serv_active_crew_details
    Log.instance.info("\n#{tmp}")
    get_active_crew_details.each do |crew|
      Log.instance.info("\n#{crew}")
      return true if tmp.include? crew
    end
  end

  def is_last_seen
    active_switch_element.click
    last_seen
  end
  
  private

  def get_active_crew_details
    crew_details = []
    active_switch_element.click
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

  def get_beacon_location
    @@list_of_beacon.each do |beacon|
      return beacon[1] if beacon.first === @@beacon.first
    end
  end

end