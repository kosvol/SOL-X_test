# frozen_string_literal: true

require './././support/env'

class Section6Page < Section4BPage
  include PageObject

  button(:save_and_next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button")
  button(:add_gas_reading_btn, xpath: "//div[starts-with(@class,'FormFieldGasReaderFactory__Container-')]/div/div/button")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button")
  elements(:total_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]/div/section")
  buttons(:back_home, xpath: "//button[starts-with(@class, 'Button__ButtonStyled')]")
  buttons(:date_and_time_btn, xpath: "//button[@id='gasLastCalibrationDate']")
  div(:rank_and_name_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][1]/div")
  div(:date_and_time_stamp, xpath: "//div[starts-with(@class,'Card-')]/div/div/div[starts-with(@class,'Cell__Content')][2]/div")

  def get_filled_section6
    tmp = []
    filled_data = $browser.find_elements(:xpath, '//input')
    tmp << filled_data[0].attribute('value')
    tmp << filled_data[1].attribute('value')
    tmp << filled_data[2].attribute('value')
    tmp << rank_and_name_stamp
    tmp
  end

  def is_gas_reader_section?
    sleep 1
    total_sections_elements.size >= 5
  end

  def toggle_to_section(_select_permit, _which_section)
    (1..get_total_steps_to_section6(_which_section)).each do |_i|
      sleep 1
      next_btn
    end
  end

  private

  def get_total_steps_to_section6(_which_section)
    case _which_section
    when '6'
      9
    when '4a'
      5
    when '3a'
      1
    when '3d'
      4
    when '4b'
      7
    when '3b'
      2
    end
  end
end
