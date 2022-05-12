# frozen_string_literal: true

require_relative '../../../service/form/ptw/permit_generator'
Given('PermitGenerator create permit') do |table|
  parms = table.hashes.first
  permit_generator = PermitGenerator.new(parms['permit_type'])
  case parms['permit_status']
  when 'created'
    permit_generator.create_created(parms['eic'], parms['gas_reading'], parms['bfr_photo'])
  when 'pending_approval'
    permit_generator.create_pending_approval(parms['eic'], parms['gas_reading'], parms['bfr_photo'])
  when 'active'
    permit_generator.create_active(parms['eic'], parms['gas_reading'], parms['bfr_photo'], parms['aft_photo'])
  when 'pending_withdrawal'
    permit_generator.create_pending_withdrawal(parms['eic'], parms['gas_reading'], parms['bfr_photo'],
                                               parms['aft_photo'])
  when 'withdrawn'
    permit_generator.create_withdrawn(parms['eic'], parms['gas_reading'], parms['bfr_photo'], parms['aft_photo'])
  when 'updates_needed'
    permit_generator.create_updates_needed(parms['eic'], parms['gas_reading'], parms['bfr_photo'], parms['aft_photo'],
                                           parms['new_status'])
  else
    raise "#{parms['permit_status']} is not implemented"
  end
  @permit_id = permit_generator.permit_id
end

Given('PermitGenerator create oa pending status permit') do |table|
  parms = table.hashes.first
  permit_generator = PermitGenerator.new(parms['permit_type'])
  permit_generator.create_oa_pending(parms['oa_status'], parms['eic'], parms['gas_reading'], parms['bfr_photo'])
  @permit_id = permit_generator.permit_id
end
