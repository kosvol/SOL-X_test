# frozen_string_literal: true

Given (/^I submit permit (.+) via service with (.+) user$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to pending approval state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state$/) do |_permit_type, _user|
  @@permit_type = _permit_type
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_yes')
end

When (/^I set permit to close$/) do
  on(BypassPage).submit_permit_for_status_change(on(BypassPage).set_permit_status('CLOSED'), '1111', @@permit_type)
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state with EIC not require$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_no', 'gas_yes')
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state with gas reading (not require|require)$/) do |_permit_type, _user, _condition|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_no') if _condition === "not require"
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_yes') if _condition === "require"
end

Given (/^I submit permit (.+) via service with (.+) user and set to pending office approval state$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes', 'gas_yes')
  on(BypassPage).set_oa_permit_to_pending_office_appr
end

Given (/^I submit permit (.+) via service with (.+) user and set to pending office approval state and no gas reading$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'pending', 'eic_yes', 'gas_no')
  on(BypassPage).set_oa_permit_to_pending_office_appr
end

Given (/^I submit permit (.+) via service with (.+) user and set to active state and no gas reading$/) do |_permit_type, _user|
  on(BypassPage).trigger_forms_submission(_permit_type, _user, 'active', 'eic_yes', 'gas_no')
end

And (/^I set (.+) permit to (.+) state$/) do |_condition, _status|
  on(BypassPage).set_oa_permit_to_active_state(_status)
end

# And (/^I set non oa permit to active state$/) do
#   on(BypassPage).set_non_oa_permit_to_active_state
# end

Given (/^I clear forms table$/) do
  SmartFormDBPage.get_table_data('fauxton', 'get_forms')
  SmartFormDBPage.delete_table_row('fauxton', 'delete_form')
end

And (/^I clear gas reader entries$/) do
  SmartFormDBPage.get_table_data('fauxton', 'get_gas_reader_entries')
  SmartFormDBPage.delete_table_row('fauxton', 'delete_gas_entries')
  SmartFormDBPage.get_table_data('oa_db', 'get_gas_reader_entries')
  SmartFormDBPage.delete_table_row('oa_db', 'delete_gas_entries')
end

And (/^I clear oa event table$/) do
  SmartFormDBPage.get_table_data('oa_db', 'get_oa_event')
  SmartFormDBPage.delete_table_row('oa_db', 'delete_oa_event')
end
