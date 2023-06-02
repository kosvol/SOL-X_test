# frozen_string_literal: true

require_relative '../base_page'

# OPManageRolePage objects
class OPManageRolePage < BasePage
  include EnvUtils

  OP_MANAGE_ROLE = {
    header: "//div[contains(@class,'ant-page-header')]/span[contains(., 'Manage Roles')]",
    create_role_header: "//div[contains(@class, 'ant-page-header')]/span[contains(., 'Create New Role')]",
    edit_role_header: "//div[contains(@class, 'ant-page-header')]/span[contains(., 'Edit Role')]",
    modal_delete_header: "//span[@class='ant-modal-confirm-title'][text()='Deleting Role']",
    modal_btn: "//div[@class='ant-modal-confirm-btns']/button[contains(., '%s')]",
    modal_delete_msg: "//span[@aria-label='deleteMessage']",
    no_roles: "//div[text()='You have no roles set']",
    name_clmn: "//tr/th[contains(., 'Name')]",
    desc_clmn: "//tr/th[contains(., 'Description')]",
    user_clmn: "//tr/th[contains(., 'User')]",
    action_clmn: "//tr/th[contains(., 'Action')]",
    name_value: "//tr/td[text()='%s']",
    role_string: "//tbody/tr[@class[contains(.,'ant-table-row')]]",
    desc_value: "/following::td[text()='%s']",
    users_value: "/following::td[text()='%s']",
    action_value: "//tr/td[text()='%s']/following::*[3]",
    role_name: "//div[@class='ant-col ant-col-24']/span[contains(., 'Role Name')]",
    description: "//div[@class='ant-col ant-col-24']/span[contains(., 'Description')]",
    permissions: "//div[@class='ant-col ant-col-24']/span[contains(., 'Permissions')]",
    perm_note: "//div[@class='ant-list-header']/div[contains(., '%s')]",
    field_name: "//input[@id='name' and @placeholder='Name']",
    field_descr: "//textarea[@id='description' and @placeholder='Description']",
    group_role: "//span[@class='ant-checkbox']/following::span[contains(., '%s')]",
    single_role: "//span[@class='ant-checkbox']/following::h4[contains(., '%s')]",
    chk_box_single: "//h4[contains(., '%s')]/preceding::*[3]",
    chk_box_group: "//span[contains(., '%s')]/preceding::*[3]",
    toast_msg: "//div[@class='ant-message-notice']/div/div/span[2]",
    valid_msg: "//span[@class[contains(.,'ant-typography-danger')]]",
    numb_items: "//span[@class[contains(.,'ant-select-selection-item')]]",
    create_btn: "//button[contains(., 'Create new role')]",
    back_arrow: "//span[@aria-label='arrow-left']",
    button: "//button[contains(., '%s')]"
  }.freeze

  def initialize(driver)
    super
    find_element(OP_MANAGE_ROLE[:header])
  end

  def verify_man_role_default
    find_element(OP_MANAGE_ROLE[:create_btn])
    find_element(OP_MANAGE_ROLE[:no_roles])
  end

  def verify_elements_man_role
    find_element(OP_MANAGE_ROLE[:create_btn])
    verify_table
  end

  def click_new_role_btn
    click(OP_MANAGE_ROLE[:create_btn])
  end

  def verify_create_role_page
    find_element(OP_MANAGE_ROLE[:create_role_header])
    find_element(OP_MANAGE_ROLE[:field_name])
    find_element(OP_MANAGE_ROLE[:field_descr])
    find_element(OP_MANAGE_ROLE[:back_arrow])
    find_element(format(OP_MANAGE_ROLE[:button], 'Cancel'))
    find_element(format(OP_MANAGE_ROLE[:button], 'Create Role'))
    verify_section_headers
  end

  def verify_edit_role_page_el
    find_element(OP_MANAGE_ROLE[:edit_role_header])
    find_element(OP_MANAGE_ROLE[:back_arrow])
    find_element(format(OP_MANAGE_ROLE[:button], 'Cancel'))
    find_element(format(OP_MANAGE_ROLE[:button], 'Save'))
    verify_section_headers
  end

  def verify_permission(table)
    table.raw.each do |group, single|
      xpath_str = format(OP_MANAGE_ROLE[:group_role], group)
      xpath_str2 = format(OP_MANAGE_ROLE[:single_role], single)
      find_element(xpath_str.to_s)
      find_element(xpath_str2.to_s)
    end
  end

  def verify_group_checkbox(table)
    table.raw.each do |group, checkbox|
      value = find_element(format(OP_MANAGE_ROLE[:chk_box_group], group)).attribute('class')
      case checkbox
      when 'checked'
        compare_string('ant-checkbox ant-checkbox-checked', value)
      when 'indeterminate'
        compare_string('ant-checkbox ant-checkbox-indeterminate', value)
      else
        compare_string('ant-checkbox', value)
      end
    end
  end

  def verify_single_checkbox(table)
    table.raw.each do |single, checkbox|
      value = find_element(format(OP_MANAGE_ROLE[:chk_box_single], single)).attribute('class')
      case checkbox
      when 'checked'
        compare_string('ant-checkbox ant-checkbox-checked', value)
      when 'indeterminate'
        compare_string('ant-checkbox ant-checkbox-indeterminate', value)
      else
        compare_string('ant-checkbox', value)
      end
    end
  end

  def fill_text_area(table)
    values = table.hashes.first
    wait_until_enabled(OP_MANAGE_ROLE[:field_name])
    clear_text(OP_MANAGE_ROLE[:field_name])
    clear_text(OP_MANAGE_ROLE[:field_descr])
    enter_text(OP_MANAGE_ROLE[:field_name], values['name'])
    enter_text(OP_MANAGE_ROLE[:field_descr], values['description'])
  end

  def select_checkbox(table)
    table.raw.each do |group, single|
      single_path = format(OP_MANAGE_ROLE[:chk_box_single], single)
      group_path = format(OP_MANAGE_ROLE[:chk_box_group], group)
      if group.to_s == ''
        click(single_path)
      elsif single.to_s == ''
        click(group_path)
      else
        click(group_path)
        click(single_path)
      end
    end
  end

  def verify_button(button, state)
    create_role_btn = format(OP_MANAGE_ROLE[:button], button)
    verify_btn_availability(create_role_btn, state)
  end

  def click_button(option)
    click(format(OP_MANAGE_ROLE[:button], option))
  end

  def verify_toast(option)
    toast_msg = retrieve_text(OP_MANAGE_ROLE[:toast_msg]) while toast_msg != option
    sleep 5
    verify_element_not_exist(OP_MANAGE_ROLE[:toast_msg])
  end

  def check_role_list(table)
    table.raw.each do |name, description, users|
      name_xpath = format(OP_MANAGE_ROLE[:name_value], name)
      desc_xpath = name_xpath + format(OP_MANAGE_ROLE[:desc_value], description)
      users_xpath = desc_xpath + format(OP_MANAGE_ROLE[:users_value], users)
      find_element(name_xpath)
      find_element(desc_xpath)
      find_element(users_xpath)
    end
  end

  def verify_valid_message(option)
    sleep 1
    valid_msg = retrieve_text(OP_MANAGE_ROLE[:valid_msg])
    compare_string(option, valid_msg)
  end

  def action_role_btn(option1, option2)
    path = format(OP_MANAGE_ROLE[:action_value], option1)
    btn_path = format(OP_MANAGE_ROLE[:button], option2)
    click(path + btn_path)
  end

  def verify_del_modal(option)
    find_element(OP_MANAGE_ROLE[:modal_delete_header])
    find_element(format(OP_MANAGE_ROLE[:modal_btn], 'Cancel'))
    find_element(format(OP_MANAGE_ROLE[:modal_btn], 'Delete'))
    exp_message = "Are you sure you want to delete the role #{option}? This action cannot be undone."
    act_message = retrieve_text(OP_MANAGE_ROLE[:modal_delete_msg])
    compare_string(exp_message, act_message)
  end

  def click_btn_delete_modal(option)
    click(format(OP_MANAGE_ROLE[:modal_btn], option))
  end

  def verify_fields(table)
    values = table.hashes.first
    compare_string(values['name'], find_element(OP_MANAGE_ROLE[:field_name]).attribute('value'))
    compare_string(values['description'], retrieve_text(OP_MANAGE_ROLE[:field_descr]))
  end

  def compare_role_count
    role = OP_MANAGE_ROLE[:role_string]
    wait_until_enabled(role)
    role_list = retrieve_elements_text_list(role).length.to_i
    page_item = (retrieve_text(OP_MANAGE_ROLE[:numb_items])).scan(/\d+/).first.to_i
    raise "Wrong numbers of roles #{role_list}" if role_list != page_item
  end

  def verify_act_role_btn(button, state, role)
    path = format(OP_MANAGE_ROLE[:action_value], role)
    btn_path = format(OP_MANAGE_ROLE[:button], button)
    verify_btn_availability(path + btn_path, state)
  end

  private

  def verify_table
    find_element(OP_MANAGE_ROLE[:name_clmn])
    find_element(OP_MANAGE_ROLE[:desc_clmn])
    find_element(OP_MANAGE_ROLE[:user_clmn])
    find_element(OP_MANAGE_ROLE[:action_clmn])
  end

  def verify_section_headers
    find_element(OP_MANAGE_ROLE[:role_name])
    find_element(OP_MANAGE_ROLE[:description])
    find_element(OP_MANAGE_ROLE[:permissions])
    find_element(format(OP_MANAGE_ROLE[:perm_note], 'This permission gives access to the following reports'))
  end

  def retrieve_elements_text_list(xpath)
    list = []
    elements = @driver.find_elements(:xpath, xpath)
    elements.each do |element|
      list << element.text
    end
    list
  end
end
