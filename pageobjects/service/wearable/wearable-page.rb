# frozen_string_literal: true

class WearablePage
  class << self
    def set_wearable_id(wearable_id)
      @wearableid = wearable_id
    end

    def get_beacon_id
      @@beacon
    end

    def link_default_crew_to_wearable(_user)
      tmp_req_payload = JSON.parse JsonUtil.read_json('wearable-simulator/base-link-crew-to-wearable')
      if _user != 'default'
        yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
        tmp_req_payload['variables']['userId'] = yml_id["ranks_id_#{$current_environment}"][_user]
      end
      JsonUtil.create_request_file('wearable-simulator/mod-base-link-crew-to-wearable', tmp_req_payload)
    end

    def get_crew_id_from_rank(_user)
      get_one_wearable_id
      tmp_req_payload = JSON.parse JsonUtil.read_json('wearable-simulator/mod-link-crew-to-wearable')
      @crewid = @list_of_crew_id.key(_user)
      tmp_req_payload['variables']['wearableId'] = @wearableid
      tmp_req_payload['variables']['userId'] = @crewid
      p ">> #{tmp_req_payload['variables']['userId']}"
      JsonUtil.create_request_file('wearable-simulator/mod-link-crew-to-wearable', tmp_req_payload)
      ServiceUtil.post_graph_ql('wearable-simulator/mod-link-crew-to-wearable')
    end

    def swap_payload(which_json, custom_value1 = nil, custom_value2 = nil)
      case which_json
      when 'wearable-simulator/mod-dismiss-panic'
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        tmp_req_payload['variables']['id'] = @wearableid
      when 'wearable-simulator/mod-trigger-panic'
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        tmp_req_payload['variables']['id'] = @wearableid
      when 'wearable-simulator/mod-link-crew-to-wearable'
        get_one_wearable_id
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        # @list_of_crew_id.delete(tmp_req_payload['variables']['userId'])
        @crewid = @list_of_crew_id.sample
        tmp_req_payload['variables']['wearableId'] = @wearableid
        tmp_req_payload['variables']['userId'] = @crewid
        p ">> #{tmp_req_payload['variables']['userId']}"
      when 'wearable-simulator/mod-unlink-crew-to-wearable'
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        tmp_req_payload['variables']['id'] = @wearableid
      when 'wearable-simulator/mod-update-wearable-location'
        @@beacon = @@list_of_beacon.sample
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        tmp_req_payload['variables']['id'] = @wearableid
        tmp_req_payload['variables']['beacons'][0]['id'] = @@beacon.first
        tmp_req_payload['variables']['beacons'][0]['mac'] = @@beacon.last
      when 'wearable-simulator/mod-update-wearable-location-by-zone'
        tmp_req_payload = JSON.parse JsonUtil.read_json(get_base_json(which_json))
        @@beacon = custom_value1
        tmp_req_payload['variables']['id'] = @wearableid
        tmp_req_payload['variables']['beacons'][0]['id'] = @@beacon
        tmp_req_payload['variables']['beacons'][0]['mac'] = custom_value2
      end
      JsonUtil.create_request_file(which_json, tmp_req_payload)
    end

    def is_location_updated
      @tmp = ServiceUtil.get_response_body['data']['wearables']
      @tmp.each do |wearable|
        if wearable['_id'] === @wearableid
          Log.instance.info("\n\n>>>>> #{wearable['location'].to_h['zone']['name']} #{@@beacon[1]}\n\n")
          return (wearable['userId'] === @crewid) && (wearable['location'].to_h['zone']['name'] === @@beacon[1])
        end
      end
    end

    def get_list_of_wearables_id
      @list_of_wearables = get_wearables_id
    end

    def get_list_of_crews_id
      @list_of_crew_id = get_crews_id
    end

    def get_list_of_crews_id_hash
      @list_of_crew_id = get_crews_id_rank
      puts(@list_of_crew_id)
    end

    def set_list_of_crews_id(_define)
      tmp = []
      tmp << _define
      @list_of_crew_id = tmp
    end

    def get_list_of_beacons_id_n_mac
      @@list_of_beacon = get_beacon_mac
    end

    # not needed now
    # def get_alternate_beacon
    #   @tmp = @@list_of_beacon.sample
    #   @@beacon === @tmp ? get_alternate_beacon : @@beacon = @tmp
    # end

    private

    @wearableid = ''

    def get_one_wearable_id
      tmp = @list_of_wearables.sample
      begin
        @wearableid != tmp.to_s ? set_wearable_id(tmp) : get_one_wearable_id
      rescue StandardError
        p(@list_of_wearables)
        p 'Empty wearables array'
      end
    end

    def get_crews_id
      @tmp_list = []
      ServiceUtil.get_response_body['data']['users'].each do |list|
        if (list['crewMember']['_id'].include? EnvironmentSelector.get_env_type_prefix)
          @tmp_list << list['crewMember']['_id']
        end
      end
      puts(@tmp_list)
      @tmp_list
    end

    def get_crews_id_rank
      @tmp_list = {}
      ServiceUtil.get_response_body['data']['users'].each do |list|
        if (list['crewMember']['rank'].include? EnvironmentSelector.get_env_type_prefix)
          @tmp_list[list['_id']] = list['crewMember']['rank']
        end
      end
      @tmp_list
    end

    def get_wearables_id
      @tmp_list = []
      ServiceUtil.get_response_body['data']['wearables'].each do |list|
        next unless ServiceUtil.get_response_body['crewMember'].nil?

        @tmp_list << list['_id']
      end
      @tmp_list
    end

    def get_beacon_mac
      @tmp_list = []
      ServiceUtil.get_response_body['data']['beacons'].each do |list|
        next if list['location']['zone'].nil?

        @tmp_list << [list['_id'], list['location']['zone']['name'], list['mac']]
      end
      @tmp_list
    end

    def get_base_json(json)
      case json
      when 'wearable-simulator/mod-update-wearable-location',
           'wearable-simulator/mod-update-wearable-location-by-zone'
        'wearable-simulator/base-update-wearable-location'
      when 'wearable-simulator/mod-unlink-crew-to-wearable'
        'wearable-simulator/base-unlink-crew-to-wearable'
      when 'wearable-simulator/mod-link-crew-to-wearable'
        'wearable-simulator/base-link-crew-to-wearable'
      when 'wearable-simulator/mod-trigger-panic'
        'wearable-simulator/base-trigger-panic'
      when 'wearable-simulator/mod-dismiss-panic'
        'wearable-simulator/base-dismiss-panic'
      end
    end
  end
end
