# frozen_string_literal: true

require_relative '../../../service/db_service'
require_relative '../../../service/personal_data_service'

Given('PersonalData service reset') do
  personal_data_service = PersonalDataService.new
  personal_data_service.reset_personal_data
end
