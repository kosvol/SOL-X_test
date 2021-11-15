# frozen_string_literal: true
require_relative '../../../service/wearable_service'

Then(/^I get a list of wearable id$/) do
  WearablePage.list_of_wearables_id
end

Then(/^I get a list of crews$/) do
  WearablePage.list_of_crews_id
end

Then(/^I get a hash of crews$/) do
  WearablePage.list_of_crews_id_hash
end

Then(/^I create rq for rank (.+)$/) do |rank|
  WearablePage.get_crew_id_from_rank(rank)
end

And(/^I manipulate wearable requeset payload$/) do
  WearablePage.swap_payload(@which_json)
end

And(/^I manipulate wearable requeset payload with (.+) and (.+)$/) do |zoneid, mac|
  WearablePage.swap_payload(@which_json, "#{EnvironmentSelector.vessel_name}-#{zoneid}", mac)
end

Then(/^I get list of beacons detail$/) do
  WearablePage.list_of_beacons_id_n_mac
end

And(/^I should see location updated$/) do
  is_true(WearablePage.location_updated?)
end
# TODO: to remove above steps once refactoring are done
And('Wearable service link crew member') do |table|
  params = table.hashes.first
  @wearable_service ||= WearableService.new
  wearables = @wearable_service.retrieve_wearables
  unused_wearable_id = @wearable_service.retrieve_unused_wearable_id(wearables)
  @wearable_service.link_crew_member(unused_wearable_id, params['rank'])
  @wearable_service.update_wearable_location(unused_wearable_id, params['zone_id'], params['mac'])
end

And('Wearable service unlink all wearables') do
  @wearable_service ||= WearableService.new
  @wearable_service.unlink_all_wearables
end
