# frozen_string_literal: true

require_relative '../entry/entry_permit_builder'
require_relative '../ptw/permit_map'
require_relative '../../utils/user_service'
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

  def create_pending_approval(creator_rank)
    creator_pin = UserService.new.retrieve_pin_by_rank(creator_rank)
    @builder.create_entry_form(creator_pin)
    self.permit_id = @builder.permit_id
    @builder.update_entry_answer
    @builder.update_form_status(@approve_type)
  end

  def create_active(creator_rank)
    create_pending_approval(creator_rank)
    @builder.approve_entry_permit
    @builder.update_form_status('APPROVED_FOR_ACTIVATION')
    @builder.update_form_status('ACTIVE')
  end

  def create_terminated(creator_rank)
    create_active(creator_rank)
    @builder.terminate_entry_permit
    @builder.update_form_status('CLOSED')
  end

  def create_updates_needed(creator_rank)
    create_pending_approval(creator_rank)
    @builder.request_update(@permit_id)
    @builder.update_form_status('APPROVAL_UPDATES_NEEDED')
  end
end
