# builder for pending approval permit

require_relative 'permit_builder'
require_relative 'permit_map'
# service to generate permit
class PermitGenerator
  def initialize(permit_type_plain)
    permit_type = PermitMap.new.retrieve_permit_type(permit_type_plain)
    @builder = PermitBuilder.new(permit_type)
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
    @builder.update_form_status('PENDING_MASTER_APPROVAL')
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

end
