Given (/^I unlink all crew from wearable$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  on(DashboardPage).unlink_all_crew_frm_wearable
end

Then (/^I should see inacive crew count is correct$/) do
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  is_equal(on(DashboardPage).get_inactive_crew_status,"Inactive (#{ServiceUtil.get_response_body['data']['crewMembers'].size})")
  is_equal(on(DashboardPage).get_total_crew_list_count,ServiceUtil.get_response_body['data']['crewMembers'].size)
end

Then (/^I should see acive crew count is correct$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/base-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  sleep 1
  is_equal("Active (#{on(DashboardPage).get_serv_active_crew_count})",on(DashboardPage).get_active_crew_status)
  step 'I toggle activity crew list'
  is_equal(on(DashboardPage).get_total_crew_list_count,on(DashboardPage).get_serv_active_crew_count)
end

Then (/^I should see active crew details$/) do
  step 'I toggle activity crew list'
  is_true(on(DashboardPage).is_crew_location_detail_correct("service")) 
end

Then (/^I should see countdown starts at 15s$/) do
  step 'I link wearable'
  on(DashboardPage).toggle_crew_activity_list
  sleep 12
  is_true(on(DashboardPage).is_last_seen.include? "secs")
end

Then (/^I should see Just now as current active crew$/) do
  step 'I link wearable'
  on(DashboardPage).toggle_crew_activity_list
  is_equal(on(DashboardPage).is_last_seen,"Just now")
end

Then (/^I should see activity indicator is (.+) 30s$/) do |indicator_color|
  step 'I link wearable'
  is_true(on(DashboardPage).is_activity_indicator_status("rgba(82, 196, 26, 1)")) if indicator_color === "green below"
  is_true(on(DashboardPage).is_activity_indicator_status("rgba(250, 173, 20, 1)")) if indicator_color === "yellow after"
end

Then (/^I should see (.+) count 1$/) do |zone|
  is_equal(on(DashboardPage).get_map_zone_count(zone), "1")
end

When (/^I link wearable$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/base-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/base-get-beacons-details request payload'
  step 'I hit graphql'
  step 'I get list of beacons detail'
  step 'I get wearable-simulator/base-update-wearable-location request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  sleep 5
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
end

And (/^I toggle activity crew list$/) do
  on(DashboardPage).toggle_crew_activity_list
end

When (/^I link wearable to zone (.+) and mac (.+)$/) do |zoneid,mac|
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/base-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{zoneid} and #{mac}"
  step 'I hit graphql'
end

And (/^I update location to new zone (.+) and mac (.+)$/) do |zoneid,mac|
  sleep 30
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{zoneid} and #{mac}"
  step 'I hit graphql'
  step 'I hit graphql'
  step 'I verify method updateWearableLocation is successful'
  step 'I wait for 1 seconds'
end

Then (/^I should see ui location updated$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  is_true(on(DashboardPage).is_crew_location_detail_correct("ui")) 
end
