# frozen_string_literal: true

# builder for pending approval permit

require_relative 'add_new_entry_builder'
require_relative '../utils/user_service'
# service to generate permit
class AddNewEntryGenerator
  def initialize(permit_type)
    default_pin = UserService.new.retrieve_pin_by_rank('C/O')
    @builder = AddNewEntryBuilder.new(permit_type, default_pin)
  end

  def create_entry_on_permit_display(array, default_pin)
    @builder.create_new_entry_record(array, default_pin)
  end
end
