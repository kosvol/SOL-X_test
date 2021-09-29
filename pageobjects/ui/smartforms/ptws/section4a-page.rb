# frozen_string_literal: true

require './././support/env'

class Section4APage < Section3DPage
  include PageObject

  elements(:occurrence,
           xpath: "(//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')])[1]/div[2]/label")
  elements(:tool_box, xpath: '//input')
  elements(:input_type_text, xpath: "//input[@type='text']")
  elements(:input_type_number, xpath: "//input[@type='number']")
  text_field(:equipment_used, xpath: "//input[@id='cl_enclosedSpacesEntry_srNoOfEquipmentUsed']")
  @@yes_input = 'div > label:nth-child(1) > span'
  @@na_input = 'div > label:nth-child(2) > span'
  elements(:rank_and_name_stamp,
           xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]")
  element(:date_and_time_stamp,
          xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]")
  elements(:textarea, xpath: '//textarea')
  spans(:list_of_checklist,
        css: 'form > section > div >section:nth-child(2) > div > div > div > span')
  elements(:rol_checklist, xpath: "//div/*[local-name()='span']")
  divs(:heavy_weather_note, xpath: "//div[starts-with(@id,'4A_HEAVY_WEATHER_subsection13')]")
  elements(:info_box, xpath: "//div[starts-with(@class,'InfoBox__')]")
  elements(:warning_box, xpath: "//div[starts-with(@class,'WarningBox__')]")
  text_fields(:disabled_fields, xpath: "//input[starts-with(@name,'energyIsolationCertIssued')]")

  # index 1 is date, index 2 is time
  elements(:checklist_date_and_time, xpath: "//button[contains(@id,'createdDate')]")
  text_field(:checklist_permit_number, xpath: "//input[contains(@name,'formNumber')]")
  button(:checklist_date, xpath: "//button[contains(@id, '_createdDate')]")
  span(:checklist_time, xpath: "//button[contains(@id, '_createdDate')]/span")

  def click_on_enter_pin
    BrowserActions.js_click("//button[contains(.,'Sign')]")
  end

  ### hack
  def select_ppe_equipment
    begin
      BrowserActions.js_click("//button[@id='cl_coldWork_followingPersonProtectiveToBeWorn']")
      sleep 1
      options_text_elements.first.click
      confirm_btn_elements.last.click
      sleep 1
    rescue StandardError
    end

    begin
      BrowserActions.js_click("//button[@id='cl_workOnHazardousSubstance_ProtectiveEquipment']")
      sleep 1
      options_text_elements.first.click
      confirm_btn_elements.last.click
      sleep 1
    rescue StandardError
    end
  end

  def fill_textarea(elems, input)
    elems.each do |text_area|
      BrowserActions.enter_text(text_area, input)
    end
  rescue StandardError
    p "Error: #{StandardError}"
  end

  def fill_up_checkbox_inputs
    tmp = 0
    sleep 2
    spacer = occurrence_elements.size
    (0..((radio_btn_elements.size / spacer) - 1)).each do |_i|
      @browser.execute_script(%(document.evaluate("//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/label/input", document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem("#{tmp}").click()))
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
    if generic_data_elements[1].text.include? get_current_date_and_time
      ((generic_data_elements[1].text.include? get_current_date_and_time)) # && (generic_data_elements[2].text.include? 'PTW/TEMP/'))
    else
      (generic_data_elements[1].text.include? get_current_date_and_time_minus_a_min.to_s)
    end
  end

  def uncheck_all_checklist
    element_yes = get_yes_elements
    list_of_checklist_elements.each_with_index do |_checklist, _index|
      next if _index === 0

      next unless element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)'

      BrowserActions.scroll_down(element_yes[_index + 3])
      sleep 1
      get_na_elements[_index].click
    end
  end

  def is_signed_user_details?(entered_pin)
    BrowserActions.wait_until_is_visible(rank_and_name_stamp_elements.first)
    rank_and_name = get_user_details_by_pin(entered_pin)
    @@tmp_rank_name = rank_and_name_stamp_elements.first.text
    Log.instance.info(">> #{@@tmp_rank_name}")
    Log.instance.info(">> Rank/Name: #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{get_current_date_and_time}")
    Log.instance.info(">> UI #{date_and_time_stamp_element.text}")
    ((@@tmp_rank_name.include? "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (date_and_time_stamp_element.text.include? date_and_time_stamp_element.text))
  end

  def is_signed_user_details_plus_1_min?(entered_pin)
    rank_and_name = get_user_details_by_pin(entered_pin)
    ((@@tmp_rank_name.include? "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (date_and_time_stamp_element.text.include? get_current_date_and_time_minus_a_min.to_s))
  end

  def is_signed_user_details_integration?(entered_pin)
    # time_offset = get_current_time_format
    rank_and_name = get_user_details_by_pin(entered_pin)
    Log.instance.info("Base Rank/Name >> #{rank_and_name_stamp_elements.first.text}")
    Log.instance.info(">> Rank/Name #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}")
    Log.instance.info(">> Date & Time #{date_and_time_stamp_element.text}")
    ((rank_and_name_stamp_elements.first.text.include? "#{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]}") && (date_and_time_stamp_element.text.include? get_current_date_format_with_offset.to_s) && (date_and_time_stamp_element.text.include? get_timezone.to_s))
  end

  # ##Blue rgba(24, 144, 255, 1)
  # ##White rgba(255, 255, 255, 1)
  def is_checklist_preselected(checklist)
    element_yes = get_yes_elements
    list_of_checklist_elements.each_with_index do |checklist_obj, index|
      next unless checklist_obj.text === checklist

      BrowserActions.scroll_down(element_yes[index])
      if checklist.include? 'Cold Work'
        return (element_yes[index].css_value('color') === 'rgba(24, 144, 255, 1)') && (get_na_elements[index].css_value('background-color') === 'rgba(255, 255, 255, 1)')
      else
        return (element_yes[index].css_value('color') === 'rgba(24, 144, 255, 1)') && (get_na_elements[index].css_value('color') === 'rgba(255, 255, 255, 1)')
      end
    end
  end

  def select_checklist(checklist)
    sleep 1
    BrowserActions.scroll_up_by_custom_dist(-600)
    element_yes = get_yes_elements
    list_of_checklist_elements.each_with_index do |checklist_obj, index|
      next unless checklist_obj.text === checklist

      BrowserActions.scroll_down(element_yes[index + 1])
      element_yes[index + 1].click
    end
  end

  def signature_scroll
    sleep 1
    BrowserActions.scroll_down(rank_and_name_stamp_elements.first)
    sleep 1
    BrowserActions.scroll_down
    sleep 1
  end

  def is_checklist_questions?
    span_arr = get_checklist_questions('div > span')
    label_arr = get_checklist_questions('div > label')
    p_arr = get_checklist_questions('div > p')
    h4_arr = get_checklist_questions('div > h4')
    is_questions = false

    base_data = YAML.load_file("data/checklist/#{@@checklist}.yml")['questions']
    base_data.each do |element|
      Log.instance.info("Checking on question >>>> #{element}")
      is_questions = (span_arr.include? element.to_s)
      next if is_questions == true

      is_questions = (label_arr.include? element.to_s)
      next if is_questions == true

      is_questions = (p_arr.include? element.to_s)
      next if is_questions == true

      is_questions = (h4_arr.include? element.to_s)
      next if is_questions == true

      if (element === 'If necessary, arrangements have been made with LSV regarding LEE, SPEED etc?') || (element === 'Is vessel movement in seaway acceptable for personnel transfer?')
        is_equal(h4_arr.size, 2)
      else
        is_equal(h4_arr.size, 1)
      end
    end
    is_questions
  end

  private

  def get_checklist_questions(css_input)
    tmp_arr = []
    tmp = @browser.find_elements(:css, css_input.to_s)
    tmp.each do |element|
      tmp_arr << element.text
    end
    tmp_arr
  end

  def get_yes_elements
    $browser.find_elements(:css, @@yes_input)
  end

  def get_na_elements
    $browser.find_elements(:css, @@na_input)
  end
end
