# frozen_string_literal: true

require_relative '../service/api/users_api'
require_relative '../service/utils/time_service'
require_relative '../service/utils/env_utils'
require 'logger'
require 'spreadsheet'

# script to generate work rest hour data
class GenWorkRestHour
  include EnvUtils
  VESSEL_ID = "#{ENV['ENVIRONMENT'].upcase}-#{ENV['VESSEL'].upcase}-VESSEL"

  def initialize
    super
    @logger = Logger.new($stdout)
  end

  def create_user_rank_list
    user_rank_list = []
    user_list_response = UsersApi.new.request
    user_list_response['data']['users'].each do |user|
      user_rank_list.append(user['_id'])
    end
    user_rank_list
  end

  def read_spread_sheet
    spreadsheet_result = []
    book = Spreadsheet.open 'scripts/wrh_data_300.xls'
    sheet1 = book.worksheet 0
    sheet1.each do |row|
      # break if row[0].nil? # if first cell empty
      spreadsheet_result.append([row[1], row[2], row[4], row[5]])
      @logger.info "vessel_location: #{row[1]}, start_time: #{row[4]}, end_time: #{row[5]}"
    end
    spreadsheet_result
  end

  def request(user_id, start_time, end_time, offset, vessel_id)
    payload = {
      "userId": user_id, "startTime": start_time, "startOffset": offset, "vesselLocation": 'SEA', "vesselId": vessel_id,
      "endTime": end_time, "endOffset": offset, "autoStopped": true
    }
    @logger.info "payload: #{payload}"
    response = RestClient.post("#{retrieve_db_url('edge')}/work_rest_hour",
                               payload.to_json,
                               { 'Content-Type' => 'application/json', 'x-auth-user' => 'system' })
    JSON.parse response.body
  end

  def run
    offset = TimeService.new.retrieve_ship_utc_offset
    user_rank_list = create_user_rank_list
    spread_list = read_spread_sheet
    spread_list.each do |data|
      next if data[3] == 'NULL'

      user_id = user_rank_list.sample
      request(user_id, data[2], data[3], offset, VESSEL_ID)
      @logger.info "request: user_id: #{user_id}, start_time: #{data[2]}, end_time: #{data[3]},vessel_id: #{vessel_id}}"
    end
  end
end
