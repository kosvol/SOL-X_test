# frozen_string_literal: true

require_relative 'entry_permit_builder'
require_relative 'permit_map'
require_relative '../utils/user_service'
# service to generate entry permit
class EntryGenerator
  attr_accessor :permit_id

  def initialize(permit_type_plain)
    permit_map = PermitMap.new
    permit_type = permit_map.retrieve_permit_type(permit_type_plain)
    @approve_type = permit_map.retrieve_approve_type(permit_type)
    default_pin = UserService.new.retrieve_pin_by_rank('C/O')
    @builder = EntryPermitBuilder.new(permit_type, default_pin)
  end

  def create_entry(permit_status)
    @builder.create_entry_form
    self.permit_id = @builder.permit_id
    @builder.update_entry_answer
    @builder.update_form_status(@approve_type)
    approve_entry_permit(permit_status) unless permit_status == 'PENDING_OFFICER_APPROVAL'
    terminate_entry_permit if permit_status == 'CLOSED'
  end

  private

  def approve_entry_permit(permit_status)
    @builder.approve_entry_permit
    @builder.update_form_status('APPROVED_FOR_ACTIVATION')
    @builder.update_form_status('ACTIVE') if permit_status == 'ACTIVE'
  end

  def terminate_entry_permit
    @builder.terminate_entry_permit
    @builder.update_form_status('CLOSED')
  end
end
