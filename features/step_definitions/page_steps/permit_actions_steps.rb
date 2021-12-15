# frozen_string_literal: true

require_relative '../../../page_objects/precre/permit_actions_page'


And('PermitActions click Submit for termination') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.terminate_permit
end

And('PermitActions click Terminate button') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.click_terminate_button
end
#Then I request update needed
And('PermitActions request for update') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.request_for_update
end

And('PermitActions click Edit Update button') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.click_edit_update
end

And('PermitActions click Edit button') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.click_edit_btn
end
#When I view permit with C/O rank
And('PermitActions open current permit for view') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.open_ptw_for_view
end

And('PermitActions verify buttons for not Pump Room Entry RO rank on pending approval page') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.verify_buttons_not_ro
end

And('PermitActions click Close button') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.click_close_button
end
#   Then I edit pre and should see the old number previously written down
And('PermitActions verify purpose of entry') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.verify_purpose_of_entry('Test Automation')
end

And('PermitActions verify button {string}') do |button|
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.verify_button_enabled(button)
end

And('PermitActions verify button {string} is disabled') do |button|
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.verify_button_disabled(button)
end
#I delete the permit created
And('PermitActions click button Delete') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.delete_current_permit
end

Then('PermitActions check Responsible Officer Signature') do |table|
  @permit_action ||= PermitActionsPage.new(@driver)
  params = table.hashes.first
  @permit_action.check_ra_signature(params['rank'], params['zone'])#'3 Cargo Tank Vent'
end

Then('PermitActions verify deleted permit not presents in list') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.verify_deleted_permit
end

#And(/^Get (PRE|CRE|PWT) id$/) do |permit_type|
And('PermitActions save permit id from list') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.save_ptw_id_from_list
end

#I (should|should not) see the current (PRE|CRE) in the "([^"]*)" list
And('PermitActions verify current permit presents in the list') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.verify_permit
end

And('PermitActions click approve for activation') do
  @permit_action ||= PermitActionsPage.new(@driver)
  @permit_action.approve_for_activation
end