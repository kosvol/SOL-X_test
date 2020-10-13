require './././support/env'

class PumpRoomEntry < Section9Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")

  elements(:all_labels, xpath: '//label')
  element(:all_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]")
  elements(:radio_button_list, xpath: "//span[@class = 'content']/..")

  button(:create_new_pre_btn, xpath: "//span[contains(text(),'Create New Pump Room Entry Permit')]//..")
  button(:add_gas_record, xpath: "//button[contains(.,'Add Gas Test Record')]")
  button(:permit_validation, xpath: "//button[@id='permitValidDuration']")

  button(:last_calibration_btn, id: 'gasLastCalibrationDate')
  button(:current_day_button_btn, xpath: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]")

  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  elements(:all_inputs, xpath: "//input[starts-with(@name,'pre_section2_pumpRoomEntry')]")

  @@alert_text =  "//div[contains(.,'%s')]"
  @@permit_duration = "//button[contains(text(),'%s')]"
  @@button = "//span[contains(text(),'%s')]//.."
  @@radio_buttons =  "//span[contains(text(),'%s')]/following::*[1]/label" # for questions
  @@interval_period_id = 'pre_section2_reportingIntervalPeriod'


  def click_create_pump_room_entry
    create_new_pre_btn
  end

  # def has_three_types_answers?(table)
  #   table.all? do |question|
  #     xpath_str = @@radio_buttons % [question[0]]
  #     elements = $browser.find_elements('xpath', xpath_str)
  #     elements.size === 3
  #   end
  # end

  def is_alert_text_visible?(alert_text)
    xpath_str = @@alert_text % [alert_text]
    @browser.find_element('xpath', xpath_str).displayed?
  rescue StandardError
    false
  end

  def select_permit_duration(duration)
    BrowserActions.scroll_click(permit_validation_element) #<--- this is how you use this method; you can change for the rest
    sleep 1
    xpath_str = @@permit_duration%[duration]
    @browser.find_element('xpath', xpath_str).click
  end

  def is_button_enabled?(button_text)
    xpath_str = @@button%[button_text]
    @browser.find_element('xpath', xpath_str).enabled?
  end

  def is_selected_date?(button)
    if button == 'Date of Last Calibration'
      BrowserActions.scroll_down(last_calibration_btn) #<-- this scroll_down is not very good;
      current_day_button_btn
      last_calibration_btn_element.text == Time.now.strftime('%d/%b/%Y')
    end
  end

  def select_answer(answer, question)
    xpath_str = @@radio_buttons%[question]
    select_checkbox(xpath_str, answer)
  end

  def is_interval_period_displayed?
    @browser.find_element('id', @@interval_period_id).displayed?
  rescue StandardError
    false
  end

  private

  def select_checkbox(where, value)
    elements = $browser.find_elements(:xpath, where)
    elements.each do |element|
      if element.text === value
        element.click
        break
      end
    end
  end

  def xpath_fast_check(xpath)
    #x = "//div[@id='PRE_SECTION_1_subsection24']"
    #test_str = %(return document.evaluate("%s", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;)%[x]
  end

end
