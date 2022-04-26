# frozen_string_literal: true

require_relative '../service/api/couch_db_api'

# CrewMemberService
class CrewMemberService
  include EnvUtils

  def initialize
    @env = ENV['ENVIRONMENT'].upcase
    @vessel_type = ENV['VESSEL'].upcase
    @couch_db_api = CouchDBAPI.new
  end

  def reset_crew_member
    crew_array = JSON.parse File.read("#{Dir.pwd}/payload/crew_members/default_crew_member.json")
    crew_array.each do |crew|
      crew['_id'] = format(crew['_id'], vessel_type: @vessel_type, env: @env)
      crew['vesselId'] = format(crew['vesselId'], env: @env, vessel_type: @vessel_type)
      @couch_db_api.post_request('edge', 'crew_members', crew.to_json)
      @couch_db_api.post_request('cloud', 'crew_members', crew.to_json)
    end
  end
end
