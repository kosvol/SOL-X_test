# frozen_string_literal: true

require_relative '../service/api/couch_db_api'

# PersonalDataService
class PersonalDataService
  include EnvUtils

  def initialize
    @env = ENV['ENVIRONMENT'].upcase
    @vessel_type = ENV['VESSEL'].upcase
    @couch_db_api = CouchDBAPI.new
  end

  def reset_personal_data
    crew_array = JSON.parse File.read("#{Dir.pwd}/payload/personal_data/default_personal_data.json")
    crew_array.each do |crew|
      crew['_id'] = format(crew['_id'], vessel_type: @vessel_type, env: @env)
      @couch_db_api.post_request('edge', 'personal_data', crew.to_json)
      @couch_db_api.post_request('cloud', 'personal_data', crew.to_json)
    end
  end
end
