# frozen_string_literal: true

require 'base64'
require_relative '../api/users_api'
require_relative '../utils/time_service'
# user service
class UserService
  def retrieve_user_id_by_rank(rank)
    user_list = UsersApi.new.request
    user_list['data']['users'].each do |user|
      return user['_id'] if user['crewMember']['rank'] == rank
    end
  end

  def retrieve_pin_by_rank(rank)
    user_list = UsersApi.new.request
    user_list['data']['users'].each do |user|
      return user['pin'] if user['crewMember']['rank'] == rank
    end
  end

  def create_default_signature(rank, vessel)
    rank_id = retrieve_user_id_by_rank(rank)
    time_service = TimeService.new
    encoded_string = Base64.encode64(File.open("#{Dir.pwd}/data/photos/signature.png", 'rb').read)
    { 'signedBy' => rank_id, 'signed' => { 'userId' => rank_id, 'rank' => rank },
      'signatureString' => "data:image/jpeg;base64, #{encoded_string}",
      'signedAt' => "#{vessel}-Z-AFT-STATION",
      'signedOn' => { 'dateTime' => time_service.retrieve_current_date_time,
                      'utcOffset' => time_service.retrieve_ship_utc_offset } }.to_json
  end

  def create_section5_signature(rank, vessel)
    rank_id = retrieve_user_id_by_rank(rank)
    time_service = TimeService.new
    encoded_string = Base64.encode64(File.open("#{Dir.pwd}/data/photos/signature.png", 'rb').read)
    [{ 'crewId' => rank_id, 'role' => 'Authorized Entrant 1', 'signed' => { 'userId' => rank_id, 'rank' => rank },
       'signature' => "data:image/jpeg;base64, #{encoded_string}",
       'signedAt' => "#{vessel}-Z-AFT-STATION",
       'signedOn' => { 'dateTime' => time_service.retrieve_current_date_time,
                       'utcOffset' => time_service.retrieve_ship_utc_offset } }].to_json
  end

  def create_section8_signature(rank, vessel)
    rank_id = retrieve_user_id_by_rank(rank)
    time_service = TimeService.new
    encoded_string = Base64.encode64(File.open("#{Dir.pwd}/data/photos/signature.png", 'rb').read)
    { '__typename' => 'SignatureWithLocation', 'signedBy' => rank_id, 'signedAt' => "#{vessel}-Z-AFT-STATION",
      'signed' => { 'userId' => rank_id, 'rank' => rank },
      'signatureString' => "data:image/jpeg;base64, #{encoded_string}",
      'signedOn' => { 'dateTime' => time_service.retrieve_current_date_time,
                      'utcOffset' => time_service.retrieve_ship_utc_offset } }.to_json
  end

  def create_gas_reading(rank, vessel)
    rank_id = retrieve_user_id_by_rank(rank)
    time_service = TimeService.new
    encoded_string = Base64.encode64(File.open("#{Dir.pwd}/data/photos/signature.png", 'rb').read)
    [{ "formId": '', "entryId": 'entry', "crewId": rank_id, "gasReadings": default_gas_reading,
       "gasReadingTime": { "dateTime": time_service.retrieve_current_date_time,
                           "utcOffset": time_service.retrieve_ship_utc_offset },
       "signature": "data:image/jpeg;base64, #{encoded_string}", "signed": { "userId": rank_id, "rank": rank },
       "gasReadingStatus": 'PENDING', "entryStatus": 'ACTIVE', "purposeOfEntry": 'Test Automation',
       "entrant": { "clientId": '', "_id": rank_id, "accessGroups": [], "firstName": 'COT', "lastName": rank,
                    "rank": rank }, "locationId": "#{vessel}-Z-AFT-STATION" }].to_json
  end

  private

  def default_gas_reading
    [{ "gasName": 'O2', "reading": '1', "unit": '%', "threshold": '20.9' },
     { "gasName": 'HC', "reading": '2', "unit": '% LEL', "threshold": '1' },
     { "gasName": 'H2S', "reading": '3', "unit": 'PPM', "threshold": '5' },
     { "gasName": 'CO', "reading": '4', "unit": 'PPM', "threshold": '25' }]
  end
end
