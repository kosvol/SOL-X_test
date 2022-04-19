# frozen_string_literal: true

require_relative '../../api/entry/ack_gas_reading_api'
require_relative '../../api/entry/create_entry_record_api'
require_relative '../../../service/utils/user_service'

# service for entry permits
class EntryService
  def initialize
    @logger = Logger.new($stdout)
    @default_rank = 'C/O'
    @default_pin = UserService.new.retrieve_pin_by_rank(@default_rank)
  end

  def accept_new_gas_reading(permit_id, entry_id, pin = @default_pin)
    response = AckGasReadingAPI.new.request(pin, permit_id, entry_id)
    @logger.debug("accept gas reading response #{response}")
  end

  def create_entry_record(permit_id, ranks_table, rank = @default_rank)
    response = CreateEntryRecordAPI.new.request(permit_id, ranks_table, rank)
    @logger.debug("create entry response: #{response}")
    response
  end

  def verify_no_pending_record(permit_id, entry_id)
    response = AckGasReadingAPI.new.request(@default_pin, permit_id, entry_id)
    raise 'ack gas response verify failed' unless response['errors'].first['message'] == 'No pending PRED record'
  end
end
