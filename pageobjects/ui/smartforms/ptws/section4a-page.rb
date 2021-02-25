# frozen_string_literal: true

require './././support/env'

class Section4APage < Section3DPage
  include PageObject

  elements(:occurrence, xpath: "(//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')])[1]/div[2]/label")
  elements(:tool_box, xpath: '//input')
  elements(:input_type_text, xpath: "//input[@type='text']")
  elements(:input_type_number, xpath: "//input[@type='number']")
  text_field(:equipment_used, xpath: "//input[@id='cl_enclosedSpacesEntry_srNoOfEquipmentUsed']")
  elements(:yes_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]")
  @@yes_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]/span"
  elements(:no_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]")
  @@na_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]/span"
  element(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]")
  element(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]")
  elements(:textarea, xpath: '//textarea')
  # elements(:enclosed_space_interval_filled_data, xpath: '//input')

  elements(:nav_dd_text, xpath: "//h3[starts-with(@class,'Heading__HeadingSmall')]") # second index
  elements(:sub_headers, xpath: '//h2')
  elements(:label_text, xpath: "//label[starts-with(@class,'Heading__HeadingSmall')]")

  elements(:section2, xpath: "//label[starts-with(@for,'cl_')]")
  divs(:subsection1, xpath: "//div[starts-with(@id,'4A_HWODA_subsection')]")

  spans(:list_of_checklist, xpath: "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span")
  elements(:section1, xpath: "//div/*[local-name()='span' or local-name()='label' or local-name()='p']")
  elements(:section4a, xpath: "//div/*/*[local-name()='span' or local-name()='label']")
  elements(:rol_checklist, xpath: "//div/*[local-name()='span']")
  element(:rol_dd_label, xpath: "//div[starts-with(@class,'ComboButtonMultiselect__Container-')]/label")

  divs(:subsectionESE1, xpath: "//div[starts-with(@id,'4A_ESE_subsection1')]")
  divs(:subsectionESE2, xpath: "//div[starts-with(@id,'4A_ESE_subsection22')]")
  divs(:subsectionESE2, xpath: "//div[starts-with(@id,'4A_ESE_subsection36')]")

  divs(:heavy_weather_note, xpath: "//div[starts-with(@id,'4A_HEAVY_WEATHER_subsection13')]")

  elements(:info_box, xpath: "//div[starts-with(@class,'InfoBox__')]")
  elements(:warning_box, xpath: "//div[starts-with(@class,'WarningBox__')]")

  text_fields(:disabled_fields, xpath: "//input[starts-with(@name,'energyIsolationCertIssued')]")
  # elements(:disabled_fields, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/input")

  text_field(:interval, xpath: "//input[@id='cl_enclosedSpacesEntry_reportingIntervalMinutes']")
  button(:ppe_btn, xpath: "//button[@id='cl_coldWork_followingPersonProtectiveToBeWorn']")
  button(:ppe1_btn, xpath: "//button[@id='cl_workOnHazardousSubstance_ProtectiveEquipment']")
  # index 1 is date, index 2 is time
  elements(:checklist_date_and_time, xpath: "//button[contains(@id,'createdDate')]")
  text_field(:checklist_permit_number, xpath: "//input[contains(@name,'formNumber')]")
  # @@checklist_permit_number = "//input[contains(@name,'formNumber')]"
  button(:checklist_date, xpath: "//button[contains(@id, '_createdDate')]")
  span(:checklist_time, xpath: "//button[contains(@id, '_createdDate')]/span")

  def click_on_enter_pin
    BrowserActions.js_click("//button[contains(.,'Sign')]")
    # @browser.execute_script(%(document.evaluate("//button[contains(.,'Enter Pin')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
  end

  # def get_checklist_locator(_checklist)
  #   tmp = if _checklist != 'ROL'
  #           section4a_elements
  #         else
  #           rol_checklist_elements
  #         end
  #   tmp
  # end

  ### hack
  def select_ppe_equipment
    begin
      BrowserActions.js_click("//button[@id='cl_coldWork_followingPersonProtectiveToBeWorn']")
      # @browser.execute_script(%(document.evaluate("//button[@id='cl_coldWork_followingPersonProtectiveToBeWorn']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
      # ppe_btn
      sleep 1
      member_name_btn_elements.first.click
      confirm_btn_elements.last.click
      sleep 1
    rescue StandardError
    end

    begin
      BrowserActions.js_click("//button[@id='cl_workOnHazardousSubstance_ProtectiveEquipment']")
      # browser.execute_script(%(document.evaluate("//button[@id='cl_workOnHazardousSubstance_ProtectiveEquipment']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
      # ppe1_btn
      sleep 1
      member_name_btn_elements.first.click
      confirm_btn_elements.last.click
      sleep 1
    rescue StandardError
    end

    # begin
    #   sleep 1
    #   member_name_btn_elements.first.click
    #   confirm_btn_elements.last.click
    #   sleep 1
    # rescue StandardError
    # end
  end

  def fill_textarea(_elems,_input)
    begin
      _elems.each do |text_area|
      BrowserActions.enter_text(text_area, _input)
    end
    rescue StandardError
      p "Error: #{StandardError}"
    end
  end

  def fill_up_checkbox_inputs
    tmp = 0
    spacer = occurrence_elements.size
    (0..((radio_btn_elements.size / spacer) - 1)).each do |_i|
      @browser.execute_script(%(document.evaluate("//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/label/input", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem("#{tmp}").click()))
      # radio_btn_elements[0 + tmp].click
      tmp += spacer
    end
  end

  def is_checklist_fields_disabled?
    !(disabled_fields_elements.size === 0)
  end

  def is_checklist_details_prepopulated?
    sleep 1
    Log.instance.info("--- #{get_current_date_and_time}")
    Log.instance.info("--- #{get_current_time_format}")
    Log.instance.info("--- #{generic_data_elements[1].text}")
    ((generic_data_elements[1].text.include? get_current_date_and_time))# && (generic_data_elements[2].text.include? 'PTW/TEMP/'))
  end

  def uncheck_all_checklist
    element_yes = get_yes_elements
    list_of_checklist_elements.each_with_index do |_checklist, _index|
      next if _index === 0

      BrowserActions.scroll_down(element_yes[_index])
      if element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)'
        get_na_elements[_index].click
      end
    end
  end

  def is_signed_user_details?(_entered_pin)
    BrowserActions.scroll_down(rank_and_name_stamp)
    sleep 1
    BrowserActions.scroll_down
    time_offset = get_current_time_format
    rank_and_name = get_user_details_by_pin(_entered_pin)
    Log.instance.info(">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{get_current_date_and_time}")
    Log.instance.info(">> UI #{date_and_time_stamp_element.text}")
    ((rank_and_name_stamp_element.text.include? "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (date_and_time_stamp_element.text.include? "#{get_current_date_and_time}"))
  end

  def is_signed_user_details_integration?(_entered_pin)
    sleep 1
    BrowserActions.scroll_down(rank_and_name_stamp)
    sleep 1
    BrowserActions.scroll_down
    # time_offset = get_current_time_format
    rank_and_name = get_user_details_by_pin(_entered_pin)
    Log.instance.info("Base Rank/Name >> #{rank_and_name_stamp_element.text}")
    Log.instance.info(">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{date_and_time_stamp_element.text}")
    ((rank_and_name_stamp_element.text.include? "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (date_and_time_stamp_element.text.include? "#{get_current_date_format_with_offset}") && (date_and_time_stamp_element.text.include? "#{get_timezone}"))
  end

  # ##Blue rgba(24, 144, 255, 1)
  # ##White rgba(255, 255, 255, 1)
  def is_checklist_preselected(_checklist)
    element_yes = get_yes_elements
    list_of_checklist_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      return (element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)')
    end
  end

  def select_checklist(_checklist)
    sleep 1
    BrowserActions.scroll_up_by_custom_dist(-600)
    element_yes = get_yes_elements
    list_of_checklist_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      element_yes[_index].click
    end
  end

  private

  def get_yes_elements
    $browser.find_elements(:xpath, @@yes_input)
  end

  def get_na_elements
    $browser.find_elements(:xpath, @@na_input)
  end

  def get_user_details_by_pin(entered_pin)
    tmp_payload = JSON.parse JsonUtil.read_json('get_user_detail_by_pin')
    tmp_payload['variables']['pin'] = format('%04d', entered_pin).to_s
    JsonUtil.create_request_file('mod_get_user_detail_by_pin', tmp_payload)
    ServiceUtil.post_graph_ql('mod_get_user_detail_by_pin')
    tmp_arr = []
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['rank']
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['firstName']
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['lastName']
    tmp_arr
  end
end
