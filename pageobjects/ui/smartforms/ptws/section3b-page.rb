# frozen_string_literal: true

require './././support/env'

class Section3BPage < Section3APage
  include PageObject

  element(:method_reason, xpath: "//input[@id='methodReason']")
  element(:last_assessment_date, xpath: "//button[@id='lastAssessment']")
  text_field(:last_assessment, xpath: "//input[@id='lastAssessmentDra']")
  button(:work_side_inspected_by, xpath: "//button[@id='workInspectionBy']")
  element(:get_inspection_by, xpath: "//*[starts-with(@class,'Input__Answer')]")
  elements(:radio_btn, css: 'input[type=radio]')
  elements(:checkbox_btn, css: 'input[type=checkbox]')

  def last_crew?
    options_text_elements.last.text == 'OLR COT OLR'
  end

  def fill_section_3b
    BrowserActions.enter_text(method_reason_element, 'Test automation')
    last_assessment_date_element.click
    sleep 1
    select_todays_date_from_calendar
    checkbox_btn_elements.first.click
    radio_btn_elements[0].click
    radio_btn_elements[3].click
    radio_btn_elements[6].click
    # date
    BrowserActions.enter_text(last_assessment_element, 'Test automation')
    radio_btn_elements[9].click
    radio_btn_elements[12].click
    sleep 50
  end

  def crew_list_populated?
    work_side_inspected_by
    !options_text_elements.empty?
  end

  def get_filled_section
    tmp = []
    generic_data_elements.each_with_index do |_data, index|
      p ">> #{generic_data_elements[index].text}"
      tmp << generic_data_elements[index].text
    end
    tmp
  end

  private

  def select_calendar
    calendar_btn
  end
end
