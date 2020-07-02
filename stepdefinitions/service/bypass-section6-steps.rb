# frozen_string_literal: true

Given (/^I trigger to bypass section6 via service with (.+) user$/) do |_user|
  on(BypassPage).trigger_forms_submission(_user)
  # SmartFormDBPage.tear_down_ptw_form(on(BypassPage).get_selected_level2_permit)
end
