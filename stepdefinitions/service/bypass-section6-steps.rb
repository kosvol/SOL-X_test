# frozen_string_literal: true

# Given (/^I trigger to bypass section6 via service with (.+) user$/) do |_user|
#   on(BypassPage).trigger_forms_submission(_user)
#   # SmartFormDBPage.tear_down_ptw_form(on(BypassPage).get_selected_level2_permit)
# end

Given (/^I submit permit (.+) via service with (.+) user and set to pending approval state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state with EIC not require$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_no')
end
