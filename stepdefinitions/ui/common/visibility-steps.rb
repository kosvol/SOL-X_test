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
    end
  elsif _condition === 'enabled'
    case _which_button
    when "sign"
      is_enabled(on(Section5Page).sign_btn_role_elements.first)
    end
  end
end