# frozen_string_literal: true

require 'require_all'
require 'logger'
require_all 'service/api'

# add new entry builder to create sections
class AddNewEntryBuilder
  def initialize(permit_type, default_pin)
    @permit_type = permit_type
    @default_pin = default_pin
    @logger = Logger.new($stdout)
    @logger.info("default pin: #{@default_pin}")
  end

  def create_new_entry_record(array, pin = @default_pin)
    create_request = if (@permit_type == 'cre') || (@permit_type == 'pre')
                       CreateNewCrePreEntry.new
                     else
                       CreateNewPTWEntry.new
                     end
    response = create_request.request(pin, array)
    response['data']['createEntryRecord']['gasReadingStatus'].eql?('PENDING')
  end
end
