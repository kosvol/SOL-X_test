# frozen_string_literal: true

require 'require_all'
require 'logger'
require_relative 'permit'
require_all 'service/api'

# entry permit builder to create sections
class EntryPermitBuilder < BasePermitBuilder
  def create_entry_form(pin = '2222')
    create_request = if @permit_type == 'cre'
                       CreateCreFormAPI.new
                     else
                       CreatePreFormAPI.new
                     end
    response = create_request.request(pin)
    @permit.permit_id = response['data']['createForm']['_id']
    @logger.info("Entry permit id: #{@permit.permit_id}")
  end

  def update_entry_answer(pin = '2222')
    update_request = if @permit_type == 'cre'
                       UpdateCreFormAnswerAPI.new
                     else
                       UpdatePreFormAnswerAPI.new
                     end
    update_request.request(@permit.permit_id, pin)
  end

  def approve_entry_permit(pin = '2222')
    ActivateEntryPermitApi.new.request(@permit.permit_id, @permit_type, pin)
  end

  def approve_entry_permit_id(permit_id, pin = '2222')
    ActivateEntryPermitApi.new.request(permit_id, @permit_type, pin)
  end

  def terminate_entry_permit(pin = '2222')
    SubmitForTerminationAPI.new.request(@permit.permit_id, @permit_type, pin)
  end
end
