# frozen_string_literal: true

require_relative 'base_page'
require_relative '../service/utils/user_service'

# EICPage object
class EICPage < BasePage
  include EnvUtils
  EIC = {
    section_header: "//h3[contains(.,'EIC')]",
    desc_of_work: '//*[@id="descOfWork"]',
    vessel_name: "(//*[starts-with(@class,'AnswerComponent__Answer')])[1]",
    created_on: "(//*[starts-with(@class,'AnswerComponent__Answer')])[2]",
    eic_no: "(//*[starts-with(@class,'AnswerComponent__Answer')])[3]",
    competent_person_sign_btn: "(//button[contains(.,'Sign')])[1]",
    issuing_authorized_sign_btn: "(//button[contains(.,'Sign')])[2]",
    location_stamp: "(//*[starts-with(@class,'AnswerComponent__Answer')])[4]",
    rank_name: "(//*[starts-with(@class, 'Cell__Description')])[1]",
    save_eic_btn: "//button[contains(.,'Save EIC')]",
    loto_yes_btn: '//*[@name="eicPreWork_LOTO" and @value="yes"]',
    elect_yes_btn: '//*[@name="eicPreWork_ElectricalIsolation" and @value="yes"]',
    physical_yes_btn: '//*[@name="eicPreWork_PhysicalIsolation" and @value="yes"]'
  }.freeze

  def initialize(driver)
    super
    find_element(EIC[:section_header])
  end

  def verify_desc_of_work(expected)
    compare_string(expected, @driver.find_element(:xpath, EIC[:desc_of_work]).attribute('value'))
  end

  def verify_pre_filled_answers
    verify_vessel_name
    verify_created_time
    verify_eic_no
  end

  def click_competent_sign_btn
    scroll_click(EIC[:competent_person_sign_btn])
  end

  def click_issuing_sign_btn
    scroll_click(EIC[:issuing_authorized_sign_btn])
  end

  def verify_signed_detail(table)
    params = table.hashes.first
    expected_rank_name = UserService.new.retrieve_rank_and_name(params['rank'])
    actual_element = find_element(EIC[:rank_name])
    sleep 0.5 until actual_element.text != 'Not Answered' # wait for location update
    compare_string(expected_rank_name, actual_element.text)
    compare_string(params['location_stamp'], retrieve_text(EIC[:location_stamp]))
  end

  def verify_button_behavior(button_type, expected)
    button_key = "#{button_type}_btn".to_sym
    element = find_element(EIC[button_key])
    if expected == 'enabled'
      raise "verify failed: expected: #{button_type} to be #{expected}" unless element.enabled?
    elsif element.enabled?
      raise "verify failed: expected: #{button_type} to be #{expected}"
    end
  end

  def answer_method_of_isolation
    scroll_click(EIC[:loto_yes_btn])
    scroll_click(EIC[:elect_yes_btn])
    scroll_click(EIC[:physical_yes_btn])
  end

  def verify_sub_questions(table)
    table.raw.each do |expected_questions|
      find_element("//*[contains(text(), '#{expected_questions.first}')]")
    end
  end

  private

  def verify_vessel_name
    compare_string(retrieve_vessel_name, retrieve_text(EIC[:vessel_name]))
  end

  def verify_created_time
    TimeService.new.retrieve_ship_utc_offset
    time_offset = TimeService.new.retrieve_ship_utc_offset
    expected_date = (Time.now + (60 * 60 * time_offset.to_i)).utc.strftime('%d/%b/%Y')
    actual_date_time = retrieve_text(EIC[:created_on])
    raise 'verify EIC time failed' unless actual_date_time.include? expected_date
  end

  def verify_eic_no
    actual = retrieve_text(EIC[:eic_no])
    expected = 'EIC/TEMP'
    raise 'verify eic no failed' unless actual.include? expected
  end
end
