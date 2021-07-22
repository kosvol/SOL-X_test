# frozen_string_literal: true

Then (/^I get a list of wearable id$/) do
  WearablePage.get_list_of_wearables_id
end

Then (/^I get a list of crews$/) do
  WearablePage.get_list_of_crews_id
end

Then (/^I get a hash of crews$/) do
  WearablePage.get_list_of_crews_id_hash
end

Then (/^I create rq for rank (.+)$/) do |_rank|
  WearablePage.get_crew_id_from_rank(_rank)
end

And (/^I manipulate wearable requeset payload$/) do
  WearablePage.swap_payload(@which_json)
end

And (/^I manipulate wearable requeset payload with (.+) and (.+)$/) do |zoneid, mac|
  WearablePage.swap_payload(@which_json, zoneid, mac)
end

Then (/^I get list of beacons detail$/) do
  WearablePage.get_list_of_beacons_id_n_mac
end

And (/^I should see location updated$/) do
  is_true(WearablePage.is_location_updated)
end
