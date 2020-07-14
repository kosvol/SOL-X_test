# frozen_string_literal: true

require './././support/env'

class Section3BPage < Section3APage
  include PageObject

  element(:method_reason, id: 'methodReason')
  text_field(:method_detail, id: '_3B_methodDetail')
  element(:last_assessment, id: 'lastAssessmentDra')
  text_field(:dra_reviewed_by, id: 'draReviewedBy')
  button(:work_side_inspected_by, id: 'workInspectionBy')
  button(:calendar_btn, xpath: "//button[starts-with(@class,'Day__DayButton')]") # select, in class have current text
  elements(:radio_btn, xpath: "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/label/input")
  elements(:crew_list, xpath: "//div[starts-with(@class,'ComboBoxWithButtons__Content')]/div/ul/li")

  def fill_section_3b
    method_reason_element.send_keys('Test automation')
    radio_btn_elements[0].click
    radio_btn_elements[3].click
    radio_btn_elements[6].click
    # date
    last_assessment_element.send_keys('Test automation')
    radio_btn_elements[9].click
    radio_btn_elements[12].click
    radio_btn_elements[15].click
  end

  def is_crew_list_populated?
    !crew_list_elements.empty?
  end

  private

  def select_calendar
    calendar_btn
  end
end
