# frozen_string_literal: true

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
  WearablePage.list_of_beacon
end

And(/^I should see location updated$/) do
  is_true(WearablePage.location_updated?)
end
