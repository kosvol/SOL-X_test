# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/op_manage_role_page'

Given('OfficeManageRole verify page without roles') do
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_man_role_default
end

Given('OfficeManageRole verify page elements') do
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_elements_man_role
end

Given('OfficeManageRole click Create new role button') do
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.click_new_role_btn
end

Given('OfficeManageRole verify "Create New Role" page elements') do
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_create_role_page
end

Then('OfficeManageRole verify "Create New Role" permissions list') do |table|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_permission(table)
end

Then('OfficeManageRole verify "Create|Edit Role" the checkbox') do |table|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_checkbox(table)
end

Then('OfficeManageRole "Create|Edit Role" fill fields') do |table|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.fill_text_area(table)
end

Then('OfficeManageRole "Create|Edit Role" select the checkbox') do |table|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.select_checkbox(table)
end

Then('OfficeManageRole "Create|Edit Role" verify the {string} button is {string}') do |option1, option2|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_button(option1, option2)
end

Then('OfficeManageRole "Create|Edit Role" click on {string} button') do |option|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.click_button(option)
end

Then('OfficeManageRole verify the toast message is shown {string}') do |option|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_toast(option)
end

Then('OfficeManageRole verify the data of created role') do |table|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.check_role_list(table)
end

Then('OfficeManageRole "Create|Edit Role" verify the validation message is shown {string}') do |option|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_valid_message(option)
end

Then('OfficeManageRole {string} click {string} button') do |option1, option2|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.action_role_btn(option1, option2)
end

Then('OfficeManageRole verify "Delete modal window" of role {string}') do |option|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_del_modal(option)
end

Then('OfficeManageRole click {string} button of "Delete modal window"') do |option|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.click_btn_delete_modal(option)
end

Then('OfficeManageRole verify "Edit Role" page elements') do |table|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_edit_role_page_el
  @office_portal_manage_role.verify_fields(table)
end

And('OfficeManageRole verify number roles per page') do
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.compare_role_count
end

Then('OfficeManageRole verify the {string} button is {string} for role {string}') do |option1, option2, option3|
  @office_portal_manage_role ||= OPManageRolePage.new(@driver)
  @office_portal_manage_role.verify_act_role_btn(option1, option2, option3)
end
