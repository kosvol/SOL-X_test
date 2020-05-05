# Given (/^I form (.+) request payload with these ID (.+)$/) do |request_payload_locality,id|
# 	@which_json = request_payload_locality
# 	FeatureCategorizer.categorizer(@@which_json).swap_payload(@@which_json,id)
# end

Given (/^I get (.+) request payload$/) do |request_payload_locality|
	@which_json = request_payload_locality
end
		
When (/^I hit graphql$/) do 
	ServiceUtil.post_graph_ql(@which_json)
end

Then (/^I should see error message (.+)$/) do |err_msg|
	is_equal(ServiceUtil.get_error_code,$error_code_yml[err_msg])
end

And (/^I verify method (.+) is successful$/) do |table|
	is_true(CommonPage.is_successful(table))
end