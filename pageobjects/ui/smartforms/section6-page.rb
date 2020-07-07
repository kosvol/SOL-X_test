# frozen_string_literal: true

require './././support/env'

class Section6Page
  include PageObject

  button(:save_and_next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button")
  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  buttons(:submit_btn, xpath: "//div[starts-with(@class,'FormFieldButtonFactory__ButtonContainer')]/button")
  elements(:total_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]/div/section")

  def is_gas_reader_section?
    total_sections_elements.size === 6
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
    end
  end
end
