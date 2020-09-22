# frozen_string_literal: true

require 'httparty'

module OfficeApproval
  include HTTParty
  class << self
    def get_office_approval_link(form_id, _role, _name)
      event_id = get_event_id(form_id)
      staff_id = get_staff_id(_role, _name)
      puts "form id >> #{form_id}"
      puts "event id >> #{event_id}"
      puts "staff id >> #{staff_id}"
      $obj_env_yml['office_approval']['format_link'] % [event_id, form_id, staff_id]
    end

    private

    def get_event_id(form_id)
      request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_event_id'], 'post', { selector: { formId: form_id } }.to_json.to_s)
      (JSON.parse request.to_s)['docs'][0]['_id']
    end

    def get_staff_id(role, name)
      request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_staff_id'], 'post', { selector: { role: role, name: name } }.to_json.to_s)
      (JSON.parse request.to_s)['docs'][0]['_id']
    end
  end
end
