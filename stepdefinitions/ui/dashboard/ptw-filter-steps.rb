# frozen_string_literal: true

Then (/^I should see permits match backend results$/) do
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'
  is_true(on(PtwFilterPage).does_permit_counter_match)
end

Then (/^I should see (.+) permits listing match counter$/) do |_which_filter|
  sleep 1
  on(Section3APage).scroll_multiple_times(20)
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'
  on(PtwFilterPage).get_permits_counter
  is_true(on(PtwFilterPage).is_permit_listing_count?(_which_filter))
end
