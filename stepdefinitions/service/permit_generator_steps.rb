# frozen_string_literal: true

require_relative '../../service/form/permit_generator'

Given(/^PermitGenerator create permit$/) do |table|
  parms = table.hashes.first
  permit_generator = PermitGenerator.new(parms['permit_type'])
  case parms['permit_status']
  when 'pending_approval'
    permit_generator.create_pending_approval(parms['eic'], parms['gas_reading'], parms['bfr_photo'])
  when 'active'
    permit_generator.create_active(parms['eic'], parms['gas_reading'], parms['bfr_photo'], parms['aft_photo'])
  when 'pending_withdrawal'
    permit_generator.create_pending_withdrawal(parms['eic'], parms['gas_reading'], parms['bfr_photo'],
                                               parms['aft_photo'])
  when 'withdrawn'
    permit_generator.create_withdrawn(parms['eic'], parms['gas_reading'], parms['bfr_photo'], parms['aft_photo'])
  else
    raise "#{parms['permit_status']} is not implemented"
  end
end