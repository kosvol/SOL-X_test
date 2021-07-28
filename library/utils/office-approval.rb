# frozen_string_literal: true

require 'httparty'

module OfficeApproval
  include HTTParty
  class << self
    def get_office_approval_link(form_id, _role, _name)
      event_id = get_event_id(form_id)[0]['_id']
      staff_id = get_staff_id(_role, _name)[0]['_id']
      Log.instance.info("form id >> #{form_id}")
      Log.instance.info("event id >> #{event_id}")
      Log.instance.info("staff id >> #{staff_id}")
      $obj_env_yml['office_approval']['format_link'] % [event_id.to_s, form_id.to_s, staff_id.to_s]
    end

    def get_event_id(form_id)
      docs = []
      i = 70
      while i > 0 && docs == []
        request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_event_id'], 'post',
                                      { selector: { formId: form_id } }.to_json.to_s)
        docs = (JSON.parse request.to_s)['docs']
        i -= 1
        sleep(10)
      end
      docs
    end

    private

    def get_staff_id(role, name)
      docs = []
      i = 70
      while i > 0 && docs == []
        request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_staff_id'], 'post',
                                      { selector: { role: role, name: name } }.to_json.to_s)
        docs = (JSON.parse request.to_s)['docs']
        i -= 1
        sleep(10)
      end
      docs
    end
  end
end
