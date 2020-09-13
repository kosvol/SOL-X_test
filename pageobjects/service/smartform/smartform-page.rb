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

    private

    def get_environment_link(_which_db, _url_map)
      if ENV['env'] === 'sit'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif ENV['env'] === 'dev'
        $obj_env_yml[_which_db.to_s]['base_dev_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif ENV['env'] === 'ngrok'
        'http://d0b02eada7fb.ngrok.io/' + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      else
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      end
    end
  end
end
