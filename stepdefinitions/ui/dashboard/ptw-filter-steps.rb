# frozen_string_literal: true

Then (/^I should see permits match backend results$/) do
  sleep 1
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'
  is_true(on(PtwFilterPage).does_permit_counter_match)
end

Then (/^I should see (.+) permits listing match counter$/) do |_which_filter|
  sleep 3
  step 'I get forms-filter/smart-form-filter request payload'
  step 'I hit graphql'
  on(PtwFilterPage).get_permits_counter

  case _which_filter
  when 'pending approval'
    if $total_pending_approval.to_i != 0
      on(CommonFormsPage).scroll_multiple_times(20)
      is_true(on(PtwFilterPage).is_permit_listing_count?(_which_filter))
    else
      to_exists(on(CommonFormsPage).no_permits_found_element)
    end
  when 'update needed'
    if $total_update_needed.to_i != 0
      is_true(on(PtwFilterPage).is_permit_listing_count?(_which_filter))
    else
      to_exists(on(CommonFormsPage).no_permits_found_element)
    end
  when 'active'
    if $total_active.to_i != 0
      is_true(on(PtwFilterPage).is_permit_listing_count?(_which_filter))
    else
      to_exists(on(CommonFormsPage).no_permits_found_element)
    end
  when 'pending withdrawal'
    if $total_terminal.to_i != 0
      is_true(on(PtwFilterPage).is_permit_listing_count?(_which_filter))
    else
      to_exists(on(CommonFormsPage).no_permits_found_element)
    end
  end
end
