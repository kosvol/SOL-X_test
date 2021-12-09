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
    add_gas_btn: "//button[contains(., 'Add Gas Test Record')]",
    done_btn: '//button[contains(.,"Done")]',
    submit_btn: "//button[contains(., 'Submit')]",
    gas_equipment_text: '//input[@id="gasEquipment"]',
    gas_sr_number_text: '//input[@id="gasSrNumber"]',
    gas_last_calibrate_text: '//button[@id="gasLastCalibrationDate"]',
    gas_disabled_warning: "//h3[contains(.,'Gas Testing Disabled')]"
  }.freeze

  GAS_READING = {
    o2: '(//*[@data-testid="gas-reading"])[1]', hc: '(//*[@data-testid="gas-reading"])[2]',
    co: '(//*[@data-testid="gas-reading"])[3]', h2s: '(//*[@data-testid="gas-reading"])[4]',
    toxic: '(//*[@data-testid="gas-reading"])[5]', signature: '//*[@class="cell signature"]'
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
    submit_btn_element = find_element(SECTION_SIX[:submit_btn])
    if option == 'enabled'
      raise 'submit btn is disabled' unless submit_btn_element.enabled?
    elsif submit_btn_element.enabled?
      raise 'submit btn is enabled'
    end
  end

  def click_add_gas_record
    scroll_click(SECTION_SIX[:add_gas_btn])
  end

  def verify_submit_btn_text(text)
    wait_for_update(retrieve_text(SECTION_SIX[:submit_btn]), text)
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

  def verify_gas_reading(table)
    params = table.hashes.first
    verify_normal_gas_reading(params)
    verify_toxic(params['Toxic'])
    verify_signature(params['Rank'])
  end

  def click_submit_btn
    click(SECTION_SIX[:submit_btn])
  end

  private

  def verify_normal_gas_reading(params)
    compare_string(params['O2'], retrieve_text(GAS_READING[:o2]))
    compare_string(params['HC'], retrieve_text(GAS_READING[:hc]))
    compare_string(params['CO'], retrieve_text(GAS_READING[:co]))
    compare_string(params['H2S'], retrieve_text(GAS_READING[:h2s]))
  end

  def verify_toxic(expected_toxic)
    expected_toxic += ' ' if expected_toxic == '-' # add space to match display
    compare_string(expected_toxic, retrieve_text(GAS_READING[:toxic]))
  end

  def verify_signature(rank)
    rank_name = UserService.new.retrieve_rank_and_name(rank)
    compare_string(rank_name, retrieve_text(GAS_READING[:signature]))
  end
end
