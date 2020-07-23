# frozen_string_literal: true

Given (/^I submit permit (.+) via service with (.+) user$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to pending approval state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state with EIC not require$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_no', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state with gas reading not require$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_no')
end

Given (/^I submit permit (.+) via service with (.+) user and set to pending office approval state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_yes')
  on(BypassPage).set_oa_permit_to_pending_office_appr
end

Given (/^I submit permit (.+) via service with (.+) user and set to pending office approval state and no gas reading$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_no')
  on(BypassPage).set_oa_permit_to_pending_office_appr
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state and no gas reading$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_no')
end

And (/^I set oa permit to active state$/) do
  on(BypassPage).set_oa_permit_to_active_state
end
