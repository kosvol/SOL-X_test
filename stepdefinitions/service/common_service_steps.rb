# frozen_string_literal: true

Given(/^I get (.+) request payload$/) do |request_payload_locality|
  @which_json = request_payload_locality
end

When(/^I hit graphql$/) do
  ServiceUtil.post_graph_ql(@which_json)
end

Then(/^I should see error message (.+)$/) do |err_msg|
  is_equal(ServiceUtil.get_error_code, $error_code_yml[err_msg])
end

And(/^I verify method (.+) is successful$/) do |table|
  is_true(CommonPage.successful?(table))
end

Given(/^I update crew members to (.*) vessel with (.*) regex$/) do |vesselType, regex|
  ServiceUtil.update_crew_members_vessel(vesselType, regex)
end
