# frozen_string_literal: true

require './././support/env'

class Section4APage < Section3DPage
  include PageObject

  elements(:tool_box, xpath: '//input')
  elements(:yes_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]")
  @@yes_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]/span"
  elements(:no_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]")
  @@na_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]/span"
  element(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]")
  element(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]")
  elements(:textarea, xpath: '//textarea')

  elements(:nav_dd_text, xpath: "//h3[starts-with(@class,'Heading__HeadingSmall')]") # second index
  elements(:sub_headers, xpath: '//h2')
  elements(:label_text, xpath: "//label[starts-with(@class,'Heading__HeadingSmall')]")

  elements(:section2, xpath: "//label[starts-with(@for,'cl_')]")
  divs(:subsection1, xpath: "//div[starts-with(@id,'4A_HWODA_subsection')]")

  spans(:list_of_checklist, xpath: "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span")
  elements(:section1, xpath: "//div/*[local-name()='span' or local-name()='label' or local-name()='p']")
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

  def get_checklist_locator(_checklist)
    tmp = if _checklist != 'ROL'
            section1_elements
          else
            rol_checklist_elements
          end
    tmp
  end

  def select_ppe_equipment
    begin
      ppe_btn
    rescue StandardError
      ppe1_btn
    end
    sleep 1
    member_name_btn_elements.first.click
    confirm_btn_elements.last.click
    sleep 1
  end

  def fill_textarea
    textarea_elements.each do |text_area|
      BrowserActions.enter_text(text_area, 'Test automation')
    end
  rescue StandardError
  end

  def is_checklist_fields_disabled?
    !(disabled_fields_elements.size === 0)
  end

  def get_current_date_mm_yyyy_format
    Time.new.strftime('%b/%Y')
  end

  def is_checklist_details_prepopulated?
    sleep 1
    Log.instance.info("--- #{get_current_date_mm_yyyy_format}")
    Log.instance.info("--- #{get_current_time_format}")
    Log.instance.info("--- #{generic_data_elements[1].text}")
    # Log.instance.info("--- #{checklist_permit_number}")
    Log.instance.info(">>> #{checklist_date_and_time_elements[0].text}")
    Log.instance.info(">>> #{checklist_date_and_time_elements[1].text}")
    # Log.instance.info(">>> #{$browser.find_element(:xpath, "//input[contains(@name,'formNumber')]").attribute('value')}")
    ((checklist_date_and_time_elements[0].text.include? get_current_date_mm_yyyy_format) && (checklist_date_and_time_elements[1].text === get_current_time_format) && (get_section1_filled_data[1] === generic_data_elements[1].text)) # BrowserActions.get_attribute_value(@@checklist_permit_number)))
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
    time_offset = get_current_time_format
    rank_and_name = get_user_details_by_pin(_entered_pin)
    Log.instance.info(">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{get_current_date_mm_yyyy_format} #{time_offset}")
    (("Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}" === rank_and_name_stamp_element.text) && ("Date & Time #{get_current_date_mm_yyyy_format} #{time_offset})" === date_and_time_stamp_element.text))
  end

  def is_signature_pad?
    signature_element
    true
  rescue StandardError
    false
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
