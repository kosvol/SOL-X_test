# frozen_string_literal: true

module SmartFormDBPage
  class << self
    def get_table_data(which_db, url_map)
      ServiceUtil.fauxton(EnvironmentSelector.get_db_url(which_db.to_s, url_map.to_s), 'get', 'fauxton/get_forms')
    end

    def delete_table_row(which_db, url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'
        next unless form['id'].include? EnvironmentSelector.get_permit_prefix

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(EnvironmentSelector.get_db_url(which_db.to_s, url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_table_wearable_alerts_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(EnvironmentSelector.get_db_url(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_oa_event_table_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'
        next unless form['doc']['formId'].include? EnvironmentSelector.get_permit_prefix

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(EnvironmentSelector.get_db_url(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_geofence_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'
        next unless form['doc']['externalId'].include? EnvironmentSelector.get_permit_prefix

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(EnvironmentSelector.get_db_url(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_crew_from_vessel(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if (form['id'].include? '_design') || (form['id'].include? 'SIT') || (form['id'].include? 'AUTO')

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(EnvironmentSelector.get_db_url(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def acknowledge_pre_entry_log
      @@pre_number = CommonPage.get_permit_id
      entry_id = get_pre_gas_entry_log_id('edge', 'get_pre_gas_entry_log', get_mod_permit_id)
      acknowledge_entry_log_payload = JSON.parse JsonUtil.read_json('pre/02.acknowledge-entry-log')
      acknowledge_entry_log_payload['variables']['formId'] = @@pre_number
      acknowledge_entry_log_payload['variables']['entryId'] = entry_id
      JsonUtil.create_request_file('pre/mod_02.acknowledge-entry-log', acknowledge_entry_log_payload)
      ServiceUtil.post_graph_ql('pre/mod_02.acknowledge-entry-log', '8383')
    end

    def get_error_message
      ServiceUtil.get_response_body['errors'].first['message']
    end

    private

    # def craft_date_time_format(_year,_month,_day,_hour,_min,_seconds)
    #   DateTime.new(_year,_month,_day,_hour,_min,_seconds).strftime("%d-%b-%YT:%H:%M:%S.%LZ")
    # end

    def get_date_time_with_offset(_offset)
      @current_time = Time.now.utc.strftime('%H')
      begin
        time_w_offset = @current_time.to_i + _offset.to_i
      rescue StandardError
        time_w_offset = @current_time.to_i + get_current_time_offset.to_i
      end
      count_hour = if time_w_offset >= 24
          (time_w_offset - 24).abs
        else
          time_w_offset
        end
      count_hour.to_s.size === 2 ? count_hour.to_s : "0#{count_hour}"
    end

    def get_mod_permit_id
      @@pre_number.gsub('/', '%2F')
    end

    def get_pre_gas_entry_log_id(which_db, url_map, which_pre_entry_log)
      uri = EnvironmentSelector.get_db_url(which_db.to_s, url_map.to_s)
      uri = format(uri, which_pre_entry_log)
      p "URI: #{uri}"
      ServiceUtil.fauxton(uri, 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['records'].first['entryId']
    end
  end
end
