# frozen_string_literal: true

require 'httparty'

module OfficeApproval
  include HTTParty
  class << self
    def get_office_approval_link(form_id, _role, _name)
      event_id = get_event_id(form_id)[0]['_id']
      staff_id = get_staff_id(_role, _name)[0]['_id']
      puts "form id >> #{form_id}"
      puts "event id >> #{event_id}"
      puts "staff id >> #{staff_id}"
      $obj_env_yml['office_approval']['format_link'] % [event_id, form_id, staff_id]
    end

    def get_event_id(form_id)
      docs = []
      i = 40
      while i > 0 && docs == [] do
        request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_event_id'], 'post', { selector: { formId: form_id } }.to_json.to_s)
        docs = (JSON.parse request.to_s)['docs']
        i -= 1
        sleep(10)
      end
      return docs
    end

    private

    def get_staff_id(role, name)
      docs = []
      i = 40
      while i > 0 && docs == [] do
        request = ServiceUtil.fauxton($obj_env_yml['office_approval']['get_staff_id'], 'post', { selector: { role: role, name: name } }.to_json.to_s)
        docs = (JSON.parse request.to_s)['docs']
        i -= 1
        sleep(10)
      end
      return docs
    end
  end
end
