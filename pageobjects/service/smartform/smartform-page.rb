# frozen_string_literal: true

class SmartFormDBPage
  class << self
    def tear_down_ptw_form(_form_id)
      rev_tag = ''
      ServiceUtil.fauxton($obj_env_yml['sit_fauxton_forms']['get_forms'], 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['rows'].each do |form|
        if form['id'] === _form_id
          rev_tag = form['value']['rev']
          break
        end
      end
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      tmp_payload['docs'][0]['_id'] = _form_id
      tmp_payload['docs'][0]['_rev'] = rev_tag
      JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
      ServiceUtil.fauxton($obj_env_yml['sit_fauxton_forms']['delete_form'], 'post', 'fauxton/delete_form')
    end

    def clear_forms_table
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.fauxton($obj_env_yml['sit_fauxton_forms']['get_forms'], 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['rows'].each do |form|
        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton($obj_env_yml['sit_fauxton_forms']['delete_form'], 'post', 'fauxton/delete_form')
      end
    end
  end
end
