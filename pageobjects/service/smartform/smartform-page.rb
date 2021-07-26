# frozen_string_literal: true

class SmartFormDBPage
  class << self
    def tear_down_ptw_form(_form_id)
      rev_tag = ''
      ServiceUtil.fauxton(get_environment_link('fauxton', 'get_forms'), 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['rows'].each do |form|
        if form['id'] === _form_id && (!form['id'].include? '_design')
          rev_tag = form['value']['rev']
          break
        end
      end
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      tmp_payload['docs'][0]['_id'] = _form_id
      tmp_payload['docs'][0]['_rev'] = rev_tag
      JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
      ServiceUtil.fauxton(get_environment_link('fauxton', 'delete_form'), 'post', 'fauxton/delete_form')
    end

    def get_table_data(_which_db, _url_map)
      ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'get', 'fauxton/get_forms')
    end

    def delete_table_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'

        # unless (($current_environment.include? 'auto') && (form['id'].include? 'AUTO')) || (($current_environment.include? 'sit') && (form['id'].include? 'SIT'))
        #   next
        # end
        next unless form['id'].include? $current_environment.upcase

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_geofence_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'

        next unless tmp_payload['docs'][0]['externalId'].include? $current_environment.upcase

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
        # tmp_payload['docs'][0]['_id'] = form['id']
        # tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        # JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        # ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_crew_from_vessel(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if (form['id'].include? '_design') || (form['id'].include? 'SIT') || (form['id'].include? 'AUTO')

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    # def delete_pre_table_row(_which_db, _url_map)
    #   tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
    #   ServiceUtil.get_response_body['rows'].each do |form|
    #     if (form['id'].include? '_design') || (form['id'].include? 'UAT') || (form['id'].include? 'PTW') || (form['id'].include? 'DRA') || (form['id'].include? 'EIC')
    #       next
    #     end

    #     tmp_payload['docs'][0]['_id'] = form['id']
    #     tmp_payload['docs'][0]['_rev'] = form['value']['rev']
    #     JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
    #     ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
    #   end
    # end

    # def delete_oa_table_row(_which_db, _url_map)
    #   tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
    #   ServiceUtil.get_response_body['rows'].each do |form|
    #     next if ((form['id'].include? '_design') || (form['id'].include? 'DEV') || (form['id'].include? 'LNGDEV') || (form['id'].include? 'UAT'))# || (form['id'].include? 'SIT'))

    #     tmp_payload['docs'][0]['_id'] = form['id']
    #     tmp_payload['docs'][0]['_rev'] = form['value']['rev']
    #     JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
    #     ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
    #   end
    # end

    def acknowledge_pre_entry_log
      entry_id = get_pre_gas_entry_log_id('fauxton', 'get_pre_gas_entry_log', get_mod_permit_id)
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

    def get_pre_gas_entry_log_id(_which_db, _url_map, _which_pre_entry_log)
      _uri = get_environment_link(_which_db.to_s, _url_map.to_s)
      _uri = format(_uri, _which_pre_entry_log)
      p "URI: #{_uri}"
      ServiceUtil.fauxton(_uri, 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['records'].first['entryId']
    end

    ## to create a module on this
    def get_environment_link(_which_db, _url_map)
      if $current_environment === 'sit' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'dev' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_dev_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'auto' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_auto_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'uat' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_uat_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'sit-fsu' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_fsu_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'sit-cot' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_cot_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif _which_db === 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      # elsif ENV['env'] === 'ngrok'
      #   'http://d0b02eada7fb.ngrok.io/' + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      else
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      end
    end
  end
end
