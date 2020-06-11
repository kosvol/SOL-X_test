# frozen_string_literal: true

Given (/^I unlink all crew from wearable$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  on(DashboardPage).unlink_all_crew_frm_wearable
end

Then (/^I should see inactive crew count is correct$/) do
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  is_equal(on(DashboardPage).inactive_status_element.text, "Inactive (#{ServiceUtil.get_response_body['data']['crewMembers'].size})")
  is_equal(on(DashboardPage).crew_list_elements.size, ServiceUtil.get_response_body['data']['crewMembers'].size)
end

Then (/^I should see active crew count is correct$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/mod-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  sleep 1
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  is_equal("Active (#{on(DashboardPage).get_serv_active_crew_count})", on(DashboardPage).active_status_element.text)
  step 'I toggle activity crew list'
  is_equal(on(DashboardPage).crew_list_elements.size, on(DashboardPage).get_serv_active_crew_count)
end

Then (/^I should see active crew details$/) do
  step 'I toggle activity crew list'
  is_true(on(DashboardPage).is_crew_location_detail_correct?('service'))
end

Then (/^I should see countdown starts at 15s$/) do
  step 'I link wearable'
  step 'I toggle activity crew list'
  sleep 12
  is_true(on(DashboardPage).is_last_seen.include?('secs'))
end

Then (/^I should see Just now as current active crew$/) do
  step 'I link wearable'
  step 'I toggle activity crew list'
  is_equal(on(DashboardPage).is_last_seen, 'Just now')
end

Then (/^I should see activity indicator is (.+) 30s$/) do |indicator_color|
  step 'I link wearable'
  if indicator_color === 'green below'
    is_true(on(DashboardPage).is_activity_indicator_status('rgba(67, 160, 71, 1)'))
  end
  if indicator_color === 'yellow after'
    is_true(on(DashboardPage).is_activity_indicator_status('rgba(242, 204, 84, 1)'))
  end
end

Then (/^I should see (.+) count represent (.+)$/) do |zone, count|
  is_equal(on(DashboardPage).get_map_zone_count(zone), count)
end

When (/^I link wearable$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/mod-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/base-get-beacons-details request payload'
  step 'I hit graphql'
  step 'I get list of beacons detail'
  step 'I get wearable-simulator/mod-update-wearable-location request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  sleep 5
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
end

And (/^I toggle activity crew list$/) do
  on(DashboardPage).toggle_crew_activity_list
end

When (/^I link wearable to zone (.+) and mac (.+)$/) do |zoneid, mac|
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/mod-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{zoneid} and #{mac}"
  step 'I hit graphql'
end

And (/^I update location to new zone (.+) and mac (.+)$/) do |zoneid, mac|
  sleep 30
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{zoneid} and #{mac}"
  step 'I hit graphql'
  step 'I hit graphql'
  step 'I verify method updateWearableLocation is successful'
  sleep 1
end

Then (/^I (should|should not) see ui location updated to (.+)$/) do |_condition, _new_zone|
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'

  if _condition === 'should'
    is_true(on(DashboardPage).is_crew_location_detail_correct?('ui', _new_zone))
  elsif _condition === 'should not'
    is_equal(on(DashboardPage).get_ui_active_crew_details.size, '0')
  end
end

Then (/^I should see (.+) location indicator showing (.+) on location pin$/) do |_location, _count|
  is_equal(on(DashboardPage).get_location_pin_text(_location), _count)
end

And (/^I should not see (.+) location indicator$/) do |_location|
  is_true(!on(DashboardPage).get_location_pin_text(_location))
end
