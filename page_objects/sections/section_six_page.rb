# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/utils/user_service'

# SectionSixPage object
class SectionSixPage < BasePage
  include EnvUtils
  SECTION_SIX = {
    section_header: "//h3[contains(.,'Section 6: Gas Testing/Equipment')]",
    gas_reading_yes: '(//*[@class="content"])[1]',
    gas_reading_no: '(//*[@class="content"])[2]',
    note: "//div[starts-with(@class,'WarningBox__')]/h3",
    field_missing_warning: "(//h3[starts-with(@class,'Heading')])[2]",
    sign_missing_warning: "(//h3[starts-with(@class,'Heading')])[4]",
    add_gas_btn: "//button[contains(., 'Add')]",
    done_btn: '//button[contains(.,"Done")]',
    submit_btn: "//button[contains(., 'Submit')]",
    updates_needed_btn: "//button[contains(., 'Updates Needed')]",
    gas_equipment_text: '//input[@id="gasEquipment"]',
    gas_sr_number_text: '//input[@id="gasSrNumber"]',
    gas_last_calibrate_text: '//button[@id="gasLastCalibrationDate"]',
    gas_disabled_warning: "//h3[contains(.,'Gas Testing Disabled')]",
    submit_oa_btn: "//button[contains(., 'Submit for Office Approval')]",
    aa_comments: '//textarea[@id="updatesNeededComment"]'
  }.freeze

  FIELD_MISSING_NOTE = 'Please Complete The Following Sections'
  SIGN_MISSING_NOTE = 'This permit has required fields missing. To submit it for approval, ' \
                      'please sign at the following sections'

  def initialize(driver)
    super
    find_element(SECTION_SIX[:section_header])
  end

  def answer_gas_reading(option)
    option == 'Yes' ? click(SECTION_SIX[:gas_reading_yes]) : click(SECTION_SIX[:gas_reading_no])
  end

  def verify_field_missing_note
    compare_string(FIELD_MISSING_NOTE, retrieve_text(SECTION_SIX[:field_missing_warning]))
  end

  def verify_sign_missing_note
    compare_string(SIGN_MISSING_NOTE, retrieve_text(SECTION_SIX[:sign_missing_warning]))
  end

  def verify_note
    find_element(SECTION_SIX[:note])
  end

  def verify_submit_btn(option)
    verify_btn_availability(SECTION_SIX[:submit_btn], option)
  end

  def click_add_gas_record
    scroll_click(SECTION_SIX[:add_gas_btn])
  end

  def verify_submit_btn_text(text)
    compare_string(retrieve_text(SECTION_SIX[:submit_btn]), text)
  end

  def verify_gas_text_fields(option)
    if option == 'should not'
      verify_element_not_exist(SECTION_SIX[:gas_equipment_text])
      verify_element_not_exist(SECTION_SIX[:gas_sr_number_text])
      verify_element_not_exist(SECTION_SIX[:gas_last_calibrate_text])
    else
      find_element(SECTION_SIX[:gas_equipment_text])
      find_element(SECTION_SIX[:gas_sr_number_text])
      find_element(SECTION_SIX[:gas_last_calibrate_text])
    end
  end

  def verify_gas_disabled_warning(option)
    if option == 'should not'
      verify_element_not_exist(SECTION_SIX[:gas_disabled_warning])
    else
      find_element(SECTION_SIX[:gas_disabled_warning])
    end
  end

  def click_done_btn
    click(SECTION_SIX[:done_btn])
  end

  def click_submit_btn
    scroll_times_direction(2, 'down')
    scroll_click(SECTION_SIX[:submit_btn])
  end

  def verify_submit_update_btn(visibility)
    if visibility == 'should'
      find_element(SECTION_SIX[:submit_btn])
      find_element(SECTION_SIX[:updates_needed_btn])
    else
      verify_element_not_exist(SECTION_SIX[:submit_btn])
      verify_element_not_exist(SECTION_SIX[:updates_needed_btn])
    end
  end

  def retrieve_permit_id
    retrieve_text('//h1')
  end

  def click_submit_oa_btn
    scroll_times_direction(2, 'down')
    scroll_click(SECTION_SIX[:submit_oa_btn])
  end

  def click_updates_needed_btn
    click(SECTION_SIX[:updates_needed_btn])
  end

  def enter_aa_comments(text)
    element = find_element(SECTION_SIX[:aa_comments])
    @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})', element)
    element.send_keys(text)
  end
end
