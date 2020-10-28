# frozen_string_literal: true

require './././support/env'

class Section8Page < Section7Page
  include PageObject

  divs(:rank_name_and_date, xpath: "//div[starts-with(@class,'Cell__Content-')]/div")
  element(:task_status_completed, xpath: "//input[@value = 'Completed']")
  buttons(:submit_termination_btn, xpath: "//button[contains(.,'Submit For Termination')]")
  button(:competent_person_btn, xpath: "//button[contains(.,'Competent Person (C/O, 2/E, E/O)')]")
  button(:issuing_authority_btn, xpath: "//button[contains(.,'Issuing Authorized (C/E)')]")
  @@competent_person_btn = "//button[contains(.,'Competent Person (C/O, 2/E, E/O)')]"
  @@issuing_authority_btn = "//button[contains(.,'Issuing Authorized (C/E)')]"

  span(:normalization_question1, xpath: "//span[contains(.,'Work completed. PTW cancellation (if applicable).')]")
  span(:normalization_question2, xpath: "//span[contains(.,'Relevant Departments personnel informed as applicable')]")
  span(:normalization_question3, xpath: "//span[contains(.,'LOTO and Warning Tag removed from Equipments / Power Supply / Control Unit / Valves')]")
  span(:normalization_question4, xpath: "//span[contains(.,'Mentioned equipments has been normalized')]")
  span(:normalization_question5, xpath: "//span[contains(.,'Normalization of energy isolation completed:')]")

  span(:normalization_elec_question1, xpath: "//span[contains(.,'Has the grounding been removed prior reconnecting power to the system?')]")
  span(:normalization_elec_question2, xpath: "//span[contains(.,'Has the newly installed and/or repaired High Voltage Equipment been subjected to a High Voltage test?')]")
  span(:normalization_crit_question1, xpath: "//span[contains(.,'Is the test/trial completed and performance is satisfactory?')]")
  span(:normalization_crit_question2, xpath: "//span[contains(.,'Equipment/procedures restore to normal?')]")
  span(:normalization_crit_question3, xpath: "//span[contains(.,'All personnel/operator have been informed of the restoration?')]")
  span(:normalization_pipe_question1, xpath: "//span[contains(.,'Have all Valves and Pipes been re-secured properly on completion of the work?')]")
  span(:normalization_pipe_question2, xpath: "//span[contains(.,'Has the section of pipe or vessel to be worked upon been purged with inert gas or Gas freed?')]")

  def sign_eic_or_issuer(_condition)
    if ['competent person', 'non competent person'].include? _condition
      if @browser.find_element(:xpath, @@competent_person_btn).displayed?
        BrowserActions.scroll_click(competent_person_btn_element)
      else
        BrowserActions.scroll_click(sign_btn_elements.first)
      end
    end
    if ['issuing authority', 'non issuing authority'].include? _condition
      if @browser.find_element(:xpath, @@issuing_authority_btn).displayed?
        BrowserActions.scroll_click(issuing_authority_btn_element)
      else
        BrowserActions.scroll_click(sign_btn_elements.first)
      end
    end
  end

  def get_signed_date_time
    BrowserActions.scroll_down(rank_and_name_stamp)
    sleep 1
    time_offset = get_current_time_format
    "#{get_current_date_format} #{time_offset}"
  end
end
