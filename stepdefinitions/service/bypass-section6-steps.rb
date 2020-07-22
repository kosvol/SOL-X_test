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
