class WearablePage
  class << self

    def set_wearable_id(wearable_id)
      @@wearableid = wearable_id
    end

    def get_beacon_id
      @@beacon
    end

    def swap_payload(which_json,custom_value1=nil,custom_value2=nil)
      case which_json
      when "wearable-simulator/base-link-crew-to-wearable"
        get_one_wearable_id
        @@crewid = @@list_of_crew_id.sample
        tmp_req_payload = JSON.parse JsonUtil.read_json(which_json)
        tmp_req_payload["variables"]["wearableId"] = @@wearableid
        tmp_req_payload["variables"]["userId"] = @@crewid
      when "wearable-simulator/base-unlink-crew-to-wearable"
        tmp_req_payload = JSON.parse JsonUtil.read_json(which_json)
        tmp_req_payload["variables"]["id"] = @@wearableid
      when "wearable-simulator/base-update-wearable-location"
        @@beacon = @@list_of_beacon.sample
        tmp_req_payload = JSON.parse JsonUtil.read_json(which_json)
        tmp_req_payload["variables"]["id"] = @@wearableid
        tmp_req_payload["variables"]["beacons"][0]["id"] = @@beacon.first
        tmp_req_payload["variables"]["beacons"][0]["mac"] = @@beacon.last
      when "wearable-simulator/mod-update-wearable-location"
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        get_alternate_beacon
        tmp_req_payload["variables"]["id"] = @@wearableid
        tmp_req_payload["variables"]["beacons"][0]["id"] = @@beacon.first
        tmp_req_payload["variables"]["beacons"][0]["mac"] = @@beacon.last
      when "wearable-simulator/mod-update-wearable-location-by-zone"
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        @@beacon = custom_value1
        tmp_req_payload["variables"]["id"] = @@wearableid
        tmp_req_payload["variables"]["beacons"][0]["id"] = @@beacon
        tmp_req_payload["variables"]["beacons"][0]["mac"] = custom_value2
      end
      JsonUtil.create_request_file(which_json,tmp_req_payload)
    end
    
    def is_location_updated
      @tmp = ServiceUtil.get_response_body['data']['wearables']
      @tmp.each do |wearable|
        if wearable["_id"] === @@wearableid
          Log.instance.info("\n\n>>>>> #{wearable["currentZone"].to_h["name"]} #{@@beacon[1]}\n\n")
          return (wearable["userId"] === @@crewid) && (wearable["currentZone"].to_h["name"] === @@beacon[1])
        end
      end
    end
    
    def get_list_of_wearables_id
      @@list_of_wearables = get_id("wearables")
    end
    
    def get_list_of_crews_id
      @@list_of_crew_id = get_id("crewMembers")
    end
    
    def get_list_of_beacons_id_n_mac
      @@list_of_beacon = get_beacon_mac
    end
    
    def get_alternate_beacon
      @tmp = @@list_of_beacon.sample
      @@beacon == @tmp ? get_alternate_beacon : @@beacon = @tmp
    end

    private

    def get_one_wearable_id
      tmp = @@list_of_wearables.sample
      tmp != "fd817c462e3f60dd" ? @@wearableid=tmp : get_one_wearable_id
    end

    def get_id(which_id)
      @@tmp_list = []
      ServiceUtil.get_response_body["data"]["#{which_id}"].each do |list|
        @@tmp_list << list["_id"]
      end
      return @@tmp_list
    end
    
    def get_beacon_mac
      @@tmp_list = []
      ServiceUtil.get_response_body["data"]["beacons"].each do |list|
        @@tmp_list << [list["_id"], list["location"]["zone"]["name"], list["mac"]]
      end
      return @@tmp_list
    end
    
    def get_base_json(json)
      case json
      when "wearable-simulator/mod-update-wearable-location",
        "wearable-simulator/mod-update-wearable-location-by-zone"
        return "wearable-simulator/base-update-wearable-location"
      end
    end
  end
end