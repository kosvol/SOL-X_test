require './././support/env'

class PumpRoomEntry < Section1Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")

  elements(:all_labels, xpath: '//label')
  element(:all_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]")
  elements(:radio_button_list, xpath: "//span[@class = 'content']/..")

  button(:create_new_pre_btn, xpath: "//span[contains(text(),'Create New Pump Room Entry Permit')]//..")
  button(:permit_validation_btn, xpath: "//button[@id='permitValidDuration']")
  button(:data_picker_btn, xpath: "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']]")

  button(:last_calibration_btn, id: 'gasLastCalibrationDate')
  button(:current_day_button_btn, xpath: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]")
  button(:submit_for_approval_btn, xpath: "//span[contains(text(),'Submit for Approval')]")

  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")

  @@pre_id ="//h4[contains(text(),'PRE No:')]/following::p"
  @@text_areas = '//textarea'
  @@alert_text = "//div[contains(.,'%s')]"
  @@permit_duration = "//button[contains(text(),'%s')]"
  @@button = "//*[contains(text(),'%s')]//.."
  @@radio_buttons = "//span[contains(text(),'%s')]/following::*[1]/label" # for questions
  @@interval_period_id = 'pre_section2_reportingIntervalPeriod'

  @@gas_test_page = "//h2[contains(text(),'%s')]"
  @@row_other_toxic_gas = "//li[starts-with(@class,'GasReadingListItem')]"

  def get_pre_no
    @browser.find_element(:xpath, @@pre_id).text
  end

  def fill_up_pre(duration)
    fill_static_pre
    select_start_time(20, 40)
    select_permit_duration(duration)
  end

  def fill_static_pre
    fill_text_area(@@text_areas, 'Test Automation')
    select_checkbox(@@radio_buttons%["Location of vesse"], ['At Sea', 'In Port'].sample)
  end

  def select_start_time(hh, mm)
    picker = "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']"
    picker_hh = "//div[@class='time-picker']//div[starts-with(@class,'picker')][1]//*[contains(text(),'%s')]" % [hh]
    picker_mm = "//div[@class='time-picker']//div[starts-with(@class,'picker')][2]//*[contains(text(),'%s')]" % [mm]
    @browser.find_element(:xpath, picker).click
    sleep 1
    BrowserActions.scroll_down
    BrowserActions.scroll_down
    @browser.find_element(:xpath, picker_hh).click
    sleep 1
    @browser.find_element(:xpath, picker_mm).click
    sleep 1

    # x = "//label[contains(text(),'Is the pumproom bilge dry?')]"
    # scr = %(document.evaluate("%s", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click())%[x]
    # @browser.execute_script(scr)  #click empty space to close picker
  end

  def click_create_pump_room_entry
    create_new_pre_btn
  end

  def are_questions?(table)
    table.all? do |question|
      xpath_str = "//span[contains(text(), '%s')]" % [question[0]]
      @browser.find_element('xpath', xpath_str).displayed?
    end
  end

  def has_three_types_answers?(table)
    table.all? do |question|
      xpath_str = @@radio_buttons % [question[0]]
      elements = $browser.find_elements('xpath', xpath_str)
      elements.size === 3
    end
  end

  def is_alert_text_visible?(alert_text)
    xpath_str = @@alert_text % [alert_text]
    @browser.find_element('xpath', xpath_str).displayed?
  rescue StandardError
    false
  end

  def select_permit_duration(duration)
    BrowserActions.scroll_click(permit_validation_btn_element)
    sleep 1
    BrowserActions.scroll_down()
    xpath_str = @@permit_duration % [duration]
    @browser.find_element('xpath', xpath_str).click
  end

  def is_button_enabled?(button_text)
    xpath_str = @@button % [button_text]
    @browser.find_element('xpath', xpath_str).enabled?
  end

  def is_selected_date?(button)
    if button == 'Date of Last Calibration'
      BrowserActions.scroll_click(last_calibration_btn_element)
      current_day_button_btn
      last_calibration_btn_element.text == Time.now.strftime('%d/%b/%Y')
    end
  end

  def select_answer(answer, question)
    xpath_str = @@radio_buttons % [question]
    select_checkbox(xpath_str, answer)
  end

  def is_interval_period_displayed?
    @browser.find_element('id', @@interval_period_id).displayed?
  rescue StandardError
    false
  end

  def is_page?(page)
    xpath_str = @@gas_test_page % [page]
    @browser.find_element("xpath", xpath_str).displayed?
  rescue StandardError
    false
  end

  def press_the_button(button)
    xpath_str = @@button % [button]
    @browser.find_element("xpath", xpath_str).click
  end

  def fill_text_input(type, selector, text)
    @browser.find_element(type, selector).send_keys(text)
  end

  def check_filled_data?(type, selector, test_data)
    @browser.find_element(type, selector).value == test_data
  end

  def fill_up_section?(section)
    if section == "Gas Test Record"
      o2_id = 'o2'
      hc_id = 'hc'
      h2s_id = "h2s"
      co_id = "co"

      test_data_o2 = "20.9"
      test_data_hc_id = "1"
      test_data_h2s_id = "5"
      test_data_co_id = "25"
      fill_text_input('id', o2_id, test_data_o2)
      fill_text_input('id', hc_id, test_data_hc_id)
      fill_text_input('id', h2s_id, test_data_h2s_id)
      fill_text_input('id', co_id, test_data_co_id)

      check_filled_data?('id', o2_id, test_data_o2) && check_filled_data?('id', hc_id, test_data_hc_id) &&
          check_filled_data?('id', h2s_id, test_data_h2s_id) && check_filled_data?('id', co_id, test_data_co_id)

    elsif section == "Other Toxic Gases"
      gas_name_id = "gasName"
      threshold_id = "threshold"
      reading_id = "reading"
      unit_id = "unit"

      test_data_gas_name = "benzene"
      test_data_threshold = "25"
      test_data_reading = "5"
      test_data_unit = "PPM"

      fill_text_input('id', gas_name_id, test_data_gas_name)
      fill_text_input('id', threshold_id, test_data_threshold)
      fill_text_input('id', reading_id, test_data_reading)
      fill_text_input('id', unit_id, test_data_unit)

      check_filled_data?('id', gas_name_id, test_data_gas_name) && check_filled_data?('id', threshold_id, test_data_threshold) &&
          check_filled_data?('id', reading_id, test_data_reading) && check_filled_data?('id', unit_id, test_data_unit)
    end
  end

  def how_many_rows
    @browser.find_elements(:xpath, @@row_other_toxic_gas).size
  end

  def delete_added_row
    stage1 = "//button[@aria-label = 'Delete']"
    stage2 = "//span[contains(text(),'Remove')]"
    @browser.find_element(:xpath, stage1).click
    @browser.find_element(:xpath, stage2).click
    how_many_rows == 0
  end

  def sign
    tmp = $browser.find_element(:xpath, '//canvas[@data-testid="signature-canvas"]')
    $browser.action.click(tmp).perform
    sleep 1
  end


  private

  def xpath_fast_check(xpath)
    #x = "//div[@id='PRE_SECTION_1_subsection24']"
    #test_str = %(return document.evaluate("%s", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;)%[x]
  end

end
