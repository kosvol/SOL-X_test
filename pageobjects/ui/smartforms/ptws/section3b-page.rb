# frozen_string_literal: true

require './././support/env'

class Section3BPage < Section3APage
  include PageObject

  element(:method_reason, id: 'methodReason')
  element(:last_assessment_date, id: 'lastAssessment')
  text_field(:last_assessment, id: 'lastAssessmentDra')
  button(:work_side_inspected_by, id: 'workInspectionBy')
  element(:get_inspection_by, xpath: "//*[starts-with(@class,'Input__Answer')]")
  elements(:radio_btn, xpath: "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/label/input")
  elements(:crew_list, xpath: "//div[starts-with(@class,'ComboBoxWithButtons__Content')]/div/ul/li")

  def is_last_crew?(_exit)
    return false if _exit === 10

    BrowserActions.scroll_down
    p "--- #{crew_list_elements.last.text}"
    crew_list_elements.last.text != 'OLR Thaian Oliveira' ? is_last_crew?(_exit.to_i + 1) : (return true)
  end

  def fill_section_3b
    BrowserActions.enter_text(method_reason_element, 'Test automation')
    last_assessment_date_element.click
    sleep 1
    select_todays_date_from_calendar
    radio_btn_elements[0].click
    radio_btn_elements[3].click
    radio_btn_elements[6].click
    # date
    BrowserActions.enter_text(last_assessment_element, 'Test automation')
    radio_btn_elements[9].click
    radio_btn_elements[12].click
    radio_btn_elements[15].click
  end

  def is_crew_list_populated?
    !crew_list_elements.empty?
  end

  def get_filled_section
    tmp = []
    generic_data_elements.each_with_index do |_data, index|
      tmp << generic_data_elements[index].text
    end
    tmp
  end

  private

  def select_calendar
    calendar_btn
  end
end