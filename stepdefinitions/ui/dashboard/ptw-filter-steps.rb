# frozen_string_literal: true

Then (/^I should see permits match backend results$/) do
  sleep 1
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'
  is_true(on(PtwFilterPage).does_permit_counter_match)
end

Then (/^I should see (.+) permits listing match counter$/) do |which_filter|
  sleep 2
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'

  on(CommonFormsPage).scroll_multiple_times_with_direction(10, down)
  sleep 1
  is_true(on(PtwFilterPage).is_permit_listing_count?(which_filter))
end
