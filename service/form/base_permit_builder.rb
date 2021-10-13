# frozen_string_literal: true

require 'logger'
require_relative 'permit'

# base permit builder to create sections
class BasePermitBuilder
  def initialize(permit_type)
    @permit_type = permit_type
    @permit = Permit.new
    @logger = Logger.new($stdout)
  end

  def update_form_status(status, permit_id = @permit.permit_id, pin = '1111')
    UpdateFormsStatusApi.new.request(permit_id, status, pin)
  end
end
