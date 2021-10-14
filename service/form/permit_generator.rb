# frozen_string_literal: true

# builder for pending approval permit

require_relative 'permit_to_work_builder'
require_relative 'entry_permit_builder'
require_relative 'permit_map'
# service to generate permit
class PermitGenerator
  def initialize(permit_type_plain)
    permit_map = PermitMap.new
    permit_type = permit_map.retrieve_permit_type(permit_type_plain)
    @approve_type = permit_map.retrieve_approve_type(permit_type)
    @builder = if %w[pre cre].include?(permit_type)
                 EntryPermitBuilder.new(permit_type)
               else
                 PermitToWorkBuilder.new(permit_type)
               end
  end

  def create_pending_approval(eic, gas_reading, bfr_photo)
    @builder.create_section0
    @builder.create_dra
    @builder.attach_photo('BEFORE_APPROVAL', bfr_photo.to_i) if bfr_photo.to_i.positive?
    @builder.create_section1
    create_section3
    create_section4(eic)
    @builder.create_section5
    @builder.create_section6(gas_reading)
    update_pending_status
  end

  def create_active(eic, gas_reading, bfr_photo, aft_photo)
    create_pending_approval(eic, gas_reading, bfr_photo)
    @builder.create_section7
    @builder.attach_photo('AFTER_APPROVAL', aft_photo.to_i) if aft_photo.to_i.positive?
    @builder.update_form_status('ACTIVE')
  end

  def create_pending_withdrawal(eic, gas_reading, bfr_photo, aft_photo)
    create_active(eic, gas_reading, bfr_photo, aft_photo)
    @builder.create_section8
    @builder.update_form_status('PENDING_TERMINATION')
  end

  def create_withdrawn(eic, gas_reading, bfr_photo, aft_photo)
    create_pending_withdrawal(eic, gas_reading, bfr_photo, aft_photo)
    @builder.create_section9
    @builder.update_form_status('CLOSED')
  end

  def create_entry(permit_status)
    @builder.create_entry_form
    @builder.update_entry_answer
    @builder.update_form_status(@approve_type)
    approve_entry_permit(permit_status) unless permit_status == 'PENDING_OFFICER_APPROVAL'
    terminate_entry_permit if permit_status == 'CLOSED'
  end

  private

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

  def update_pending_status
    if @approve_type == 'PENDING_OFFICE_APPROVAL'
      @builder.update_form_status('PENDING_MASTER_REVIEW')
      @builder.update_form_status('PENDING_OFFICE_APPROVAL')
    else
      @builder.update_form_status('PENDING_MASTER_APPROVAL')
    end
  end

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
