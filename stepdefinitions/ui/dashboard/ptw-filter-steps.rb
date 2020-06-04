# frozen_string_literal: true

Then (/^I should see permits match backend results$/) do
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'
  is_true(on(PtwFilterPage).click_create_permit_btn)
end
