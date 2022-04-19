# frozen_string_literal: true

require 'logger'
require_relative 'ptw/permit'

# base permit builder to create sections
class BasePermitBuilder
  def initialize(permit_type, default_pin)
    @permit_type = permit_type
    @default_pin = default_pin
    @permit = Permit.new
    @logger = Logger.new($stdout)
    @logger.debug("permit type #{@permit_type}")
    @logger.debug("default pin: #{@default_pin}")
  end

  def update_form_status(status, permit_id = self.permit_id, pin = @default_pin)
    request_retry = 0
    response = UpdateFormsStatusApi.new.request(permit_id, status, pin)
    while response.key?('errors')
      response = UpdateFormsStatusApi.new.request(permit_id, status, pin)
      sleep 0.5
      request_retry += 1
      break if request_retry > 10
    end
    @logger.debug("PTW #{status} update response: #{response}")
    response
  end

  def request_update(permit_id)
    RequestUpdateAPI.new.request(permit_id, @default_pin)
  end
end
