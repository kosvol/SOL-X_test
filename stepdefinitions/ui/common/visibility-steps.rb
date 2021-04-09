Then (/^I should see (.*) button (disabled|enabled)$/) do |_which_button,_condition|
  sleep 1
  on(Section3APage).scroll_multiple_times(3)
  if _condition === 'disabled'
    case _which_button
    when "Add Gas"
      is_disabled(on(Section6Page).add_gas_btn_element)
    when "submit"
      is_disabled(on(PendingStatePage).submit_for_master_approval_btn_elements.first)
    when "sign"
      is_disabled(on(Section5Page).sign_btn_role_elements.first)
    when "Add Gas Reading"
      sleep 1
      is_equal(on(Section6Page).gas_yes_no_elements.size,0)
      not_to_exists(on(Section6Page).gas_last_calibration_button_element)
      not_to_exists(on(Section6Page).gas_equipment_input_element)
      not_to_exists(on(Section6Page).gas_sr_number_input_element)
      # _enable_or_disable === 'enabled' ? is_enabled(on(Section6Page).add_gas_btn_element) : is_disabled(on(Section6Page).add_gas_btn_element)
      is_disabled(on(Section6Page).add_gas_btn_element)
    when "Retrieve My Data"
      on(CrewListPage).add_new_crew_btn
      is_disabled(on(CrewListPage).retrieve_data_btn_element)
    when "Updates Needed"
      is_disabled(on(Section7Page).update_btn_element)
    when "Approve for Activation"
      is_disabled(on(PumpRoomEntry).approve_activation)
    end
  elsif _condition === 'enabled'
    case _which_button
    when "sign"
      is_enabled(on(Section5Page).sign_btn_role_elements.first)
    when "submit"
      on(Section3APage).scroll_multiple_times(3)
      is_equal(on(CommonFormsPage).submit_for_master_approval_btn_elements.size,1)
      is_enabled(on(CommonFormsPage).submit_for_master_approval_btn_elements.first)
    when "Approve for Activation"
      is_enabled(on(PumpRoomEntry).approve_activation_element)
    when "Updates Needed"
      is_enabled(on(Section7Page).update_btn_element)
    when "Activate Permit to Work"
      is_equal(on(Section7Page).non_oa_buttons_elements.first.text, 'Activate Permit To Work')
    end
  end
end

Then (/^I should see section (.*) screen$/) do |_which_section|
  screen_title = @browser.find_elements(:xpath, "//nav/h3[starts-with(@class,'Heading__H3')]").first.text
  case _which_section
  when '8'
    is_equal(screen_title,"Section 8: Task Status & EIC Normalisation")
  when '6'
    is_equal(screen_title,"Section 6: Gas Testing/Equipment")
  end
end