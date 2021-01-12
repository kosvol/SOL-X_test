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

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def acknowledge_pre_entry_log(_which_pre_entry_log)
      entry_id = get_pre_gas_entry_log_id('fauxton', 'get_pre_gas_entry_log',_which_pre_entry_log)
      acknowledge_entry_log_payload = JSON.parse JsonUtil.read_json("pre/02.acknowledge-entry-log")
      acknowledge_entry_log_payload['variables']['formId'] = @@pre_number
      acknowledge_entry_log_payload['variables']['entryId'] = entry_id
      JsonUtil.create_request_file('pre/mod_02.acknowledge-entry-log', acknowledge_entry_log_payload)
      ServiceUtil.post_graph_ql('pre/mod_02.acknowledge-entry-log', '8383')
    end

    private

    def get_pre_gas_entry_log_id(_which_db,_url_map,_which_pre_entry_log)
      _uri = get_environment_link(_which_db.to_s, _url_map.to_s)
      _uri = _uri % [_which_pre_entry_log]
      p "URI: #{_uri}"
      ServiceUtil.fauxton(_uri, 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['records'].first['entryId']
    end

    def get_environment_link(_which_db, _url_map)
      if ENV['env'] === 'sit'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif ENV['env'] === 'dev'
        $obj_env_yml[_which_db.to_s]['base_dev_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      # elsif ENV['env'] === 'ngrok'
      #   'http://d0b02eada7fb.ngrok.io/' + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      else
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      end
    end
  end
end
