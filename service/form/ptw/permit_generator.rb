# frozen_string_literal: true

require_relative 'permit_to_work_builder'
require_relative 'permit_map'
require_relative '../../utils/user_service'
# service to generate ptw permit
class PermitGenerator
  attr_accessor :permit_id

  def initialize(permit_type_plain)
    @permit_type = permit_type_plain
    permit_map = PermitMap.new
    permit_type = permit_map.retrieve_permit_type(permit_type_plain)
    @approve_type = permit_map.retrieve_approve_type(permit_type)
    default_pin = UserService.new.retrieve_pin_by_rank('C/O')
    @builder = PermitToWorkBuilder.new(permit_type, default_pin)
  end

  def create_created(eic, gas_reading, bfr_photo)
    if @permit_type == 'rigging_of_ladder'
      create_rol_pending_sections
    else
      create_pending_sections(eic, gas_reading, bfr_photo)
    end
    self.permit_id = @builder.permit_id
  end

  def create_pending_approval(eic, gas_reading, bfr_photo)
    create_created(eic, gas_reading, bfr_photo)
    update_pending_status('PENDING_MASTER_APPROVAL')
    self.permit_id = @builder.permit_id
  end

  def create_active(eic, gas_reading, bfr_photo, aft_photo)
    create_pending_approval(eic, gas_reading, bfr_photo)
    if @permit_type == 'rigging_of_ladder'
      @builder.create_rol_section2_validity
    else
      @builder.create_section7
      @builder.attach_photo('AFTER_APPROVAL', aft_photo.to_i) if aft_photo.to_i.positive?
    end
    @builder.update_form_status('ACTIVE')
  end

  def create_pending_withdrawal(eic, gas_reading, bfr_photo, aft_photo)
    create_active(eic, gas_reading, bfr_photo, aft_photo)
    if @permit_type == 'rigging_of_ladder'
      @builder.create_rol_section3_task_st
    else
      @builder.create_section8
    end
    @builder.update_form_status('PENDING_TERMINATION')
  end

  def create_withdrawn(eic, gas_reading, bfr_photo, aft_photo)
    create_pending_withdrawal(eic, gas_reading, bfr_photo, aft_photo)
    if @permit_type == 'rigging_of_ladder'
      @builder.create_rol_section3_withdrawn
    else
      @builder.create_section9
    end
    @builder.update_form_status('CLOSED')
  end

  def create_updates_needed(eic, gas_reading, bfr_photo, aft_photo, new_status)
    case new_status
    when 'APPROVAL_UPDATES_NEEDED'
      create_pending_approval(eic, gas_reading, bfr_photo)
    when 'TERMINATION_UPDATES_NEEDED'
      create_pending_withdrawal(eic, gas_reading, bfr_photo, aft_photo)
    else
      raise "#{new_status} not supported"
    end
    @builder.request_update(@permit_id)
    @builder.update_form_status(new_status)
  end

  def update_pending_status(pending_status)
    case pending_status
    when 'PENDING_MASTER_REVIEW'
      @builder.update_form_status('PENDING_MASTER_REVIEW')
    when 'PENDING_OFFICE_APPROVAL'
      update_oa_pending_status
    else
      update_oa_pending_status if @approve_type == 'PENDING_OFFICE_APPROVAL'
      @builder.update_form_status('PENDING_MASTER_APPROVAL')
    end
  end

  def create_oa_pending(oa_status, eic, gas_reading, bfr_photo)
    create_pending_sections(eic, gas_reading, bfr_photo)
    update_pending_status(oa_status)
    self.permit_id = @builder.permit_id
  end

  private

  def create_pending_sections(eic, gas_reading, bfr_photo)
    @builder.create_section0
    @builder.create_dra
    @builder.attach_photo('BEFORE_APPROVAL', bfr_photo.to_i) if bfr_photo.to_i.positive?
    @builder.create_section1
    create_section3
    create_section4(eic)
    @builder.create_section5
    @builder.create_section6(gas_reading)
  end

  def create_rol_pending_sections
    @builder.create_section0
    @builder.create_dra
    @builder.create_rol_section1
    @builder.create_rol_section2_checklist
  end

  def create_section3
    @builder.create_section3a
    @builder.create_section3b
    @builder.create_section3c
    @builder.create_section3d
  end

  def create_section4(eic)
    @builder.create_section4a
    @builder.create_section4a_checklist
    @builder.create_section4b_detail(eic)
    create_eic_sections if eic == 'yes'
  end

  def create_eic_sections
    @builder.create_section4b_eic
    @builder.create_section4b_eic_detail
  end

  def update_oa_pending_status
    @builder.update_form_status('PENDING_MASTER_REVIEW')
    @builder.update_form_status('PENDING_OFFICE_APPROVAL')
  end
end
