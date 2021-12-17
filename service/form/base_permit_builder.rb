# frozen_string_literal: true

require 'logger'
require_relative 'permit'

# base permit builder to create sections
class BasePermitBuilder
  def initialize(permit_type, default_pin)
    @permit_type = permit_type
    @default_pin = default_pin
    @permit = Permit.new
    @logger = Logger.new($stdout)
    @logger.info("permit type #{@permit_type}")
    @logger.info("default pin: #{@default_pin}")
  end

  def update_form_status(status, permit_id = self.permit_id, pin = @default_pin)
    UpdateFormsStatusApi.new.request(permit_id, status, pin)
  end
end
