# frozen_string_literal: true

Given (/^I unlink all crew from wearable$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  on(DashboardPage).unlink_all_crew_frm_wearable
  sleep 2
end

Then (/^I should see correct table headers for crew list$/) do
  is_equal(on(DashboardPage).crew_list_headers_elements.first.text,"Rank")
  is_equal(on(DashboardPage).crew_list_headers_elements[1].text,"Surname")
  is_equal(on(DashboardPage).crew_list_headers_elements[2].text,"Location")
  is_equal(on(DashboardPage).crew_list_headers_elements[3].text,"Permit To Work")
  is_equal(on(DashboardPage).crew_list_headers_elements.last.text,"Last Seen")
end

Then (/^I should see crew link to PTW$/) do
  p ">> #{on(DashboardPage).permit_to_work_element.text}"
  does_include(on(DashboardPage).permit_to_work_element.text,CommonPage.get_permit_id)
end

Then (/^I should see active crew details$/) do
  is_true(on(DashboardPage).is_crew_location_detail_correct?('service'))
end

Then (/^I should see countdown starts at 15s$/) do
  step 'I link wearable'
  sleep 12
  is_true(on(DashboardPage).is_last_seen.include?('secs'))
end

Then (/^I should see Just now as current active crew$/) do
  step 'I link wearable'
  is_equal(on(DashboardPage).is_last_seen, 'Just now')
end

Then (/^I should see activity indicator is (.+) 5 minutes$/) do |indicator_color|
  step 'I link wearable'
  if indicator_color === 'green below'
    is_true(on(DashboardPage).is_activity_indicator_status('rgba(67, 160, 71, 1)'))
  end
  if indicator_color === 'yellow after'
    is_true(on(DashboardPage).is_activity_indicator_status('rgba(242, 204, 84, 1)'))
  end
end

Then (/^I should see (.+) count represent (.+)$/) do |zone, count|
  is_equal(on(DashboardPage).get_map_zone_count(zone, count), "#{zone} (#{count})")
  on(DashboardPage).dismiss_area_dd
end

And (/^I link crew to wearable$/) do
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  step 'I get a list of wearable id'
  step 'I get wearable-simulator/base-get-list-of-crew request payload'
  step 'I hit graphql'
  step 'I get a list of crews'
  step 'I get wearable-simulator/mod-link-crew-to-wearable request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
end

When (/^I link wearable$/) do
  step 'I link crew to wearable'
  step 'I get wearable-simulator/base-get-beacons-details request payload'
  step 'I hit graphql'
  step 'I get list of beacons detail'
  step 'I get wearable-simulator/mod-update-wearable-location request payload'
  step 'I manipulate wearable requeset payload'
  step 'I hit graphql'
  step 'I hit graphql'
  sleep 3
  step 'I get wearable-simulator/base-get-wearable-details request payload'
  step 'I hit graphql'
  sleep 2
end

When (/^I link wearable to zone (.+) and mac (.+)$/) do |_zoneid, _mac|
  step 'I link crew to wearable'
  step 'I get wearable-simulator/mod-update-wearable-location-by-zone request payload'
  step "I manipulate wearable requeset payload with #{_zoneid} and #{_mac}"
  step 'I hit graphql'
  sleep 1
  step 'I hit graphql'
  sleep 2
end

And (/^I click on any ptw$/) do
  selected_ptw = rand((on(DashboardPage).permit_to_work_link_elements.size-1))
  @ptw_id = on(DashboardPage).permit_to_work_link_elements[selected_ptw].text
  p ">> #{@ptw_id}"
  on(DashboardPage).permit_to_work_link_elements[selected_ptw].click
end

Then (/^I should see correct permit display$/) do
  is_equal(on(Section0Page).ptw_id_element.text,@ptw_id)
end

When (/^I link default user wearable$/) do
  WearablePage.link_default_crew_to_wearable
  step "I get wearable-simulator/mod-base-link-crew-to-wearable request payload"
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

And (/^I expand location drop down menu$/) do
  on(DashboardPage).expand_area_dd
end

And (/^I collapse location drop down menu$/) do
  on(DashboardPage).dismiss_area_dd
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

When (/^I submit a scheduled PRE permit$/) do
  on(BypassPage).trigger_pre_submission('8383')
end

Then (/^I should see 25 crews link to dashboard$/) do
  sleep 10 #default 3 seconds; hack to bypass some optimization problem
  is_equal(on(DashboardPage).crew_list_elements.size,25)
end

Then (/^I (should not|should) see PRE tab active on dashboard$/) do |_condition|
  if _condition === 'should'
    is_equal(on(DashboardPage).pre_indicator, 'Active')
    is_true(on(DashboardPage).is_pre_indicator_color?('active'))
  elsif _condition === 'should not'
    is_equal(on(DashboardPage).pre_indicator, 'Inactive')
    is_true(on(DashboardPage).is_pre_indicator_color?('inactive'))
  end
end

When (/^I (terminate|close) the (PRE|CRE) permit via service$/) do |_action,_permit_type|
  on(BypassPage).terminate_pre_permit('8383') if _action == "terminate"
  on(BypassPage).close_permit(_permit_type,'8383',ENV['ENVIRONMENT']) if _action == "close"
end

When (/^I Close Permit (.+) via service (.+)$/) do |_permit_type, _env|
  on(BypassPage).close_permit(_permit_type,'9015',_env)
end

When (/^I submit a (scheduled|current) CRE permit via service$/) do |_type|
  on(BypassPage).trigger_cre_submission('8383', 'current') if _type == 'current'
  on(BypassPage).trigger_cre_submission('8383', 'scheduled') if _type == 'scheduled'
end

When (/^I signout entrants "([^"]*)"$/) do |_entrants|
  _entrants.split(',').each do |item|
    on(BypassPage).signout_entrants(item.to_s)
  end
end


