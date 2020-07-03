# frozen_string_literal: true

Given (/^I trigger to bypass section6 via service with (.+) user$/) do |_user|
  on(BypassPage).trigger_forms_submission(_user)
  # SmartFormDBPage.tear_down_ptw_form(on(BypassPage).get_selected_level2_permit)
end

Given (/^I submit permit (.+) via service with (.+) user$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user)
end
