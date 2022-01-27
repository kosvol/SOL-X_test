# frozen_string_literal: true

require 'require_all'
require 'logger'
require_relative '../utils/user_service'
require_all 'service/api'

# Acknowledge entry record
class AcknowledgeEntryRecord

  def initialize
    @default_pin = UserService.new.retrieve_pin_by_rank('C/O')
    @logger = Logger.new($stdout)
    @logger.info("default pin: #{@default_pin}")
  end

  def acknowledge_entry_record(pre_number, entry_id, pin = @default_pin)
    create_request = AcknowledgeGasReadings.new
    create_request.request(pin, pre_number, entry_id)
  end

end
