# frozen_string_literal: true

require './././support/env'

class Section4APage < Section3DPage
  include PageObject

  elements(:tool_box, xpath: '//input')
  elements(:yes_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]")
  @@yes_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]/span"
  elements(:no_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]")
  @@na_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]/span"
  button(:enter_pin_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button[1]")
  element(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]")
  element(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]")
  elements(:textarea, xpath: '//textarea')

  elements(:nav_dd_text, xpath: "//h3[starts-with(@class,'Heading__HeadingSmall')]") # second index
  elements(:sub_headers, xpath: '//h2')
  elements(:label_text, xpath: "//label[starts-with(@class,'Heading__HeadingSmall')]")
  spans(:section1, xpath: "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span")
  elements(:section2, xpath: "//label[starts-with(@for,'cl_')]")
  divs(:subsection1, xpath: "//div[starts-with(@id,'4A_HWODA_subsection')]")
  divs(:subsection1ESE, xpath: "//div[starts-with(@id,'4A_ESE_subsection')]")
  elements(:info_box, xpath: "//div[starts-with(@class,'InfoBox__')]")
  elements(:warning_box, xpath: "//div[starts-with(@class,'WarningBox__')]")
  elements(:disabled_fields, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/input")

  button(:ppe_btn, xpath: "//button[@id='cl_coldWork_followingPersonProtectiveToBeWorn']")
  button(:ppe1_btn, xpath: "//button[@id='cl_workOnHazardousSubstance_ProtectiveEquipment']")
  # index 1 is date, index 2 is time
  elements(:checklist_date_and_time, xpath: "//button[contains(@id,'createdDate')]")
  text_field(:checklist_permit_number, xpath: "//input[contains(@name,'formNumber')]")
  # @@checklist_permit_number = "//input[contains(@name,'formNumber')]"

  def select_ppe_equipment
    BrowserActions.hide_keyboard
    begin
      ppe_btn
    rescue StandardError
      ppe1_btn
    end
    sleep 1
    member_name_btn_elements.first.click
    cancel_and_confirm_btn_elements.last.click
    sleep 1
  end

  def fill_textarea
    textarea_elements.each do |text_area|
      text_area.send_keys('Test Automation')
    end
  rescue StandardError
  end

  def is_checklist_fields_disabled?
    !(disabled_fields_elements.size === 0)
  end

  def get_filled_section4a
    tmp = []
    filled_data = $browser.find_elements(:xpath, '//input')
    filled_data.each_with_index do |_data, index|
      tmp << filled_data[index].attribute('value')
    end
    tmp
  end

  def get_current_date_mm_yyyy_format
    Time.new.strftime('%b/%Y')
  end

  def is_checklist_details_prepopulated?
    sleep 1
    Log.instance.info("--- #{get_current_date_mm_yyyy_format}")
    Log.instance.info("--- #{get_current_time_format}")
    Log.instance.info("--- #{checklist_permit_number}")
    Log.instance.info(">>> #{checklist_date_and_time_elements[0].text}")
    Log.instance.info(">>> #{checklist_date_and_time_elements[1].text}")
    Log.instance.info(">>> #{$browser.find_element(:xpath, "//input[contains(@name,'formNumber')]").attribute('value')}")
    ((checklist_date_and_time_elements[0].text.include? get_current_date_mm_yyyy_format) && (checklist_date_and_time_elements[1].text === get_current_time_format) && (get_section1_filled_data[1] === checklist_permit_number)) # BrowserActions.get_attribute_value(@@checklist_permit_number)))
  end

  def uncheck_all_checklist
    element_yes = get_yes_elements
    section1_elements.each_with_index do |_checklist, _index|
      next if _index === 0

      BrowserActions.scroll_down(element_yes[_index])
      if element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)'
        get_na_elements[_index].click
      end
    end
  end

  def get_checklist_label(_which_content, checklist = nil)
    case _which_content
    when 'labels'
      web_elements = label_text_elements
    when 'sections'
      web_elements = if checklist != 'Enclosed Space Entry Checklist'
                       subsection1_elements
                     else
                       subsection1ESE_elements
                     end
    when 'subheaders'
      web_elements = sub_headers_elements
    when 'section1'
      web_elements = section1_elements
    when 'section2'
      web_elements = section2_elements
    when 'info_box'
      web_elements = info_box_elements
    when 'warning_box'
      web_elements = warning_box_elements
    end
    data_arr = []
    web_elements.each do |label|
      data_arr << label.text
    end
    p ">> #{data_arr}"
    data_arr
  rescue StandardError
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

  # ##Blue rgba(24, 144, 255, 1)
  # ##White rgba(255, 255, 255, 1)
  def is_checklist_preselected(_checklist)
    element_yes = get_yes_elements
    section1_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      return (element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)')
    end
  end

  def is_hazardous_substance_checklist
    element_yes = get_yes_elements
    section1_elements.each_with_index do |checklist, _index|
      next unless checklist.text === 'Work on Hazardous Substances'

      BrowserActions.scroll_down(element_yes[_index])
      return (checklist.text === 'Work on Hazardous Substances') && (element_yes[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)')
    end
  end

  def select_checklist(_checklist)
    element_yes = get_yes_elements
    section1_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      element_yes[_index].click
    end
  end

  def get_checklist_base_data(_checklist)
    case _checklist
    when 'Hot Work Outside Designated Area'
      YAML.load_file('data/checklist/Hot Work Outside Designated Area.yml')
    when 'Hot Work Within Designated Area'
      YAML.load_file('data/checklist/Hot Work Within Designated Area.yml')
    when 'Critical Equipment Maintenance Checklist'
      YAML.load_file('data/checklist/Critical Equipment Maintenance.yml')
    when 'Enclosed Space Entry Checklist'
      YAML.load_file('data/checklist/Enclosed Space Entry Checklist.yml')
    when 'Underwater Operation'
      YAML.load_file('data/checklist/Underwater Operation.yml')
    when 'Working Aloft/Overside'
      YAML.load_file('data/checklist/Working Aloft Overside.yml')
    when 'Work on Pressure Pipelines'
      YAML.load_file('data/checklist/Work on pressure pipelines pressure vessels.yml')
    when 'Use of ODME in Manual Mode'
      YAML.load_file('data/checklist/ODME.yml')
    when 'Personnel Transfer by Transfer Basket'
      YAML.load_file('data/checklist/Personnel Transfer by Transfer Basket.yml')
    when 'Helicopter Operation Checklist'
      YAML.load_file('data/checklist/Helicopter Operation.yml')
    when 'Work on Electrical Equipment and Circuits'
      YAML.load_file('data/checklist/Work on Electrical Equipments and Circuit.yml')
    when 'Rotational Portable Power Tools (PPT)'
      YAML.load_file('data/checklist/Rotational Portable Power tools.yml')
    when 'Use of Camera Checklist'
      YAML.load_file('data/checklist/Use of Camera.yml')
    when 'Work on Deck During Heavy Weather'
      YAML.load_file('data/checklist/Working on Deck During Heavy Weather.yml')
    when 'Cold Work Operation Checklist'
      YAML.load_file('data/checklist/Cold Work.yml')
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
