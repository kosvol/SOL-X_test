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

    def load_work_rest_hour
      tmp_payload = JSON.parse JsonUtil.read_json('wrh/work-rest-hour')
      tmp_payload['docs'].each_with_index do |_doc,_index|
        userid = _doc['userId']
        userid[0,4] = "SIT" if $current_environment === 'sit'
        tmp_payload['docs'][_index]['userId'] = userid
      end
      
      # ## 13h59m
      ttt = tmp_payload['docs'][0]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][0]['startTime'] = ttt
      ttt = tmp_payload['docs'][0]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][0]['endTime'] = ttt

      ttt = tmp_payload['docs'][1]['startTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][1]['startTime'] = ttt
      ttt = tmp_payload['docs'][1]['endTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][1]['endTime'] = ttt

      ttt = tmp_payload['docs'][2]['startTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][2]['startTime'] = ttt
      ttt = tmp_payload['docs'][2]['endTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][2]['endTime'] = ttt

      # ## 9h59m
      ttt = tmp_payload['docs'][3]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][3]['startTime'] = ttt
      ttt = tmp_payload['docs'][3]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][3]['endTime'] = ttt

      ttt = tmp_payload['docs'][4]['startTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][4]['startTime'] = ttt
      ttt = tmp_payload['docs'][4]['endTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][4]['endTime'] = ttt

      # ## 71h59m
      ttt = tmp_payload['docs'][5]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][5]['startTime'] = ttt
      ttt = tmp_payload['docs'][5]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][5]['endTime'] = ttt

      ttt = tmp_payload['docs'][6]['startTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][6]['startTime'] = ttt
      ttt = tmp_payload['docs'][6]['endTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][6]['endTime'] = ttt

      ttt = tmp_payload['docs'][7]['startTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][7]['startTime'] = ttt
      ttt = tmp_payload['docs'][7]['endTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][7]['endTime'] = ttt

      ttt = tmp_payload['docs'][8]['startTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][8]['startTime'] = ttt
      ttt = tmp_payload['docs'][8]['endTime']
      ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][8]['endTime'] = ttt

      ttt = tmp_payload['docs'][9]['startTime']
      ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][9]['startTime'] = ttt
      ttt = tmp_payload['docs'][9]['endTime']
      ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][9]['endTime'] = ttt

      ttt = tmp_payload['docs'][10]['startTime']
      ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][10]['startTime'] = ttt
      ttt = tmp_payload['docs'][10]['endTime']
      ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][10]['endTime'] = ttt

      ttt = tmp_payload['docs'][11]['startTime']
      ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][11]['startTime'] = ttt
      ttt = tmp_payload['docs'][11]['endTime']
      ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][11]['endTime'] = ttt

      ttt = tmp_payload['docs'][12]['startTime']
      ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][12]['startTime'] = ttt
      ttt = tmp_payload['docs'][12]['endTime']
      ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][12]['endTime'] = ttt

      ttt = tmp_payload['docs'][13]['startTime']
      ttt[0,10] = (Date.today-4).strftime("%Y-%m-%d")
      tmp_payload['docs'][13]['startTime'] = ttt
      ttt = tmp_payload['docs'][13]['endTime']
      ttt[0,10] = (Date.today-4).strftime("%Y-%m-%d")
      tmp_payload['docs'][13]['endTime'] = ttt

      ttt = tmp_payload['docs'][14]['startTime']
      ttt[0,10] = (Date.today-5).strftime("%Y-%m-%d")
      tmp_payload['docs'][14]['startTime'] = ttt
      ttt = tmp_payload['docs'][14]['endTime']
      ttt[0,10] = (Date.today-5).strftime("%Y-%m-%d")
      tmp_payload['docs'][14]['endTime'] = ttt

      ### AUTO_SOLX0007
      ttt = tmp_payload['docs'][15]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][15]['startTime'] = ttt
      ttt = tmp_payload['docs'][15]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][15]['endTime'] = ttt

      ttt = tmp_payload['docs'][16]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][16]['startTime'] = ttt
      ttt = tmp_payload['docs'][16]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][16]['endTime'] = ttt

      ### AUTO_SOLX0008
      ttt = tmp_payload['docs'][17]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][17]['startTime'] = ttt
      ttt = tmp_payload['docs'][17]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][17]['endTime'] = ttt

      ttt = tmp_payload['docs'][18]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][18]['startTime'] = ttt
      ttt = tmp_payload['docs'][18]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][18]['endTime'] = ttt

      ttt = tmp_payload['docs'][19]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][19]['startTime'] = ttt
      ttt = tmp_payload['docs'][19]['endTime']
      ttt[0,10] = (Date.today+1).strftime("%Y-%m-%d")
      tmp_payload['docs'][19]['endTime'] = ttt

      ### AUTO_SOLX0009
      ttt = tmp_payload['docs'][20]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['startTime'] = ttt
      ttt = tmp_payload['docs'][20]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['endTime'] = ttt

      ttt = tmp_payload['docs'][20]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['startTime'] = ttt
      ttt = tmp_payload['docs'][20]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['endTime'] = ttt

      ttt = tmp_payload['docs'][20]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['startTime'] = ttt
      ttt = tmp_payload['docs'][20]['endTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['endTime'] = ttt

      ttt = tmp_payload['docs'][20]['startTime']
      ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['startTime'] = ttt
      ttt = tmp_payload['docs'][20]['endTime']
      ttt[0,10] = (Date.today+1).strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['endTime'] = ttt
  
      JsonUtil.create_request_file('wrh/mod-wrk-rest-hr', tmp_payload)
      ServiceUtil.fauxton(get_environment_link('fauxton', 'add-work-rest-hour'), 'post', 'wrh/mod-wrk-rest-hr')
    end

    def get_table_data(_which_db, _url_map)
      ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'get', 'fauxton/get_forms')
    end

    def delete_table_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if ((form['id'].include? '_design') || (form['id'].include? 'DEV') || (form['id'].include? 'LNGDEV') || (form['id'].include? 'UAT'))# || (form['id'].include? 'SIT'))

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_pre_table_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if ((form['id'].include? '_design') || (form['id'].include? 'DEV') || (form['id'].include? 'LNGDEV') || (form['id'].include? 'UAT') || (form['id'].include? 'PTW') || (form['id'].include? 'DRA') || (form['id'].include? 'EIC'))

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

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
      entry_id = get_pre_gas_entry_log_id('fauxton', 'get_pre_gas_entry_log',get_mod_permit_id)
      acknowledge_entry_log_payload = JSON.parse JsonUtil.read_json("pre/02.acknowledge-entry-log")
      acknowledge_entry_log_payload['variables']['formId'] = @@pre_number
      acknowledge_entry_log_payload['variables']['entryId'] = entry_id
      JsonUtil.create_request_file('pre/mod_02.acknowledge-entry-log', acknowledge_entry_log_payload)
      ServiceUtil.post_graph_ql('pre/mod_02.acknowledge-entry-log', '8383')
    end

    def get_error_message
      ServiceUtil.get_response_body['errors'].first['message']
    end

    private

    def get_mod_permit_id
      @@pre_number.gsub("/", "%2F")
    end

    def get_pre_gas_entry_log_id(_which_db,_url_map,_which_pre_entry_log)
      _uri = get_environment_link(_which_db.to_s, _url_map.to_s)
      _uri = _uri % [_which_pre_entry_log]
      p "URI: #{_uri}"
      ServiceUtil.fauxton(_uri, 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['records'].first['entryId']
    end

    def get_environment_link(_which_db, _url_map)
      if $current_environment === 'sit' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'dev' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_dev_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'auto' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_auto_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif _which_db === 'oa_db'
        "https://admin:gkmQjrP6Lmsd1tvZLTez@couchdb.dev.solas.magellanx.io" + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      # elsif ENV['env'] === 'ngrok'
      #   'http://d0b02eada7fb.ngrok.io/' + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      else
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      end
    end
  end
end
