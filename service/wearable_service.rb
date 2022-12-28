# frozen_string_literal: true

require_relative '../service/api/wearable_api'
require_relative '../service/utils/user_service'

# service for wearable
class WearableService
  include EnvUtils

  def initialize
    @wearable_api = WearableAPI.new
    @logger = Logger.new($stdout)
  end

  def retrieve_wearables(pin = '1111')
    wearables = @wearable_api.retrieve_wearables(pin)
    @logger.debug("wearables response: #{wearables}")
    wearables
  end

  def retrieve_unused_wearable_id(wearable_list)
    wearable_list['data']['wearables'].each do |wearable|
      return wearable['_id'] if wearable['userId'].nil?
    end
  end

  def link_crew_member(wearable_id, rank, pin = '1111')
    user_id = UserService.new.retrieve_user_id_by_rank(rank)
    @logger.debug("link wearable: #{wearable_id} with user: #{user_id}")
    @wearable_api.link_crew_wearable(wearable_id, user_id, pin)
  end

  def update_wearable_location(wearable_id, mac, pin = '1111')
    @logger.debug("update wearable: #{wearable_id}")
    @wearable_api.update_wearable_location(wearable_id, mac, pin)
  end

  def unlink_all_wearables(pin = '1111')
    wearables = retrieve_wearables
    @logger.debug('unlink all wearables')
    wearables['data']['wearables'].each do |wearable|
      @wearable_api.unlink_wearable(wearable['_id'], pin) unless wearable['userId'].nil?
    end
  end

  def send_crew_assist(wearable_list)
    wearable_list['data']['wearables'].each do |wearable|
      if !wearable['userId'].nil?
        @wearable_api.send_alert(wearable['_id'], '1111')
      else
        @logger.debug "There is no Active user for Wearable #{wearable['_id']}"
      end
    end
  end

  def dismiss_crew_assist(wearable_list)
    wearable_list['data']['wearables'].each do |wearable|
      if !wearable['userId'].nil?
        @wearable_api.dismiss_alert(wearable['_id'], '1111')
      else
        @logger.debug "There is no Active user for Wearable #{wearable['_id']}"
      end
    end
  end

  def crew_assist_get_location(rank)
    wearable_list = retrieve_wearables
    wearable_list['data']['wearables'].each do |wearable|
      puts "!!Rank = #{wearable['crewMember']['rank']}"
      puts "!!Location = #{wearable['location']['zone']['name']}"
      return wearable['location']['zone']['name'] if wearable['crewMember']['rank'] == rank
    end
  end
end
