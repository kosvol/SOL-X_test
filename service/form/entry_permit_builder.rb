# frozen_string_literal: true

require 'require_all'
require 'logger'
require_relative 'permit'
require_relative 'base_permit_builder'
require_all 'service/api'

# entry permit builder to create sections
class EntryPermitBuilder < BasePermitBuilder
  attr_accessor :permit_id

  def create_entry_form(pin = @default_pin)
    create_request = if @permit_type == 'cre'
                       CreateCreFormAPI.new
                     else
                       CreatePreFormAPI.new
                     end
    response = create_request.request(pin)
    self.permit_id = response['data']['createForm']['_id']
    @logger.info("Entry permit id: #{permit_id}")
  end

  def update_entry_answer(pin = @default_pin)
    update_request = if @permit_type == 'cre'
                       UpdateCreFormAnswerAPI.new
                     else
                       UpdatePreFormAnswerAPI.new
                     end
    update_request.request(permit_id, pin)
  end

  def approve_entry_permit(pin = @default_pin)
    ActivateEntryPermitApi.new.request(permit_id, @permit_type, pin)
  end

  def terminate_entry_permit(pin = @default_pin)
    SubmitForTerminationAPI.new.request(permit_id, @permit_type, pin)
  end
end
