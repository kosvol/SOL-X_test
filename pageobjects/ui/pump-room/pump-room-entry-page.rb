require '././support/env'

class PumpRoomEntry < PreDisplay
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  element(:current_activity_pre, xpath: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span")
  element(:pre_id, xpath: "//h4[contains(text(),'PRE No:')]/following::p")
  element(:create_new_pre_btn, xpath: "//span[contains(.,'Create New Pump')]")
  element(:create_new_cre_btn, xpath: "//span[contains(.,'Create New Compressor')]")
  button(:permit_validation_btn, xpath: "//button[@id='permitValidDuration']")
  button(:current_day_button_btn, xpath: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]")
  button(:four_hours_duration, xpath: "//button[contains(text(),'4 hours')]")
  button(:six_hours_duration, xpath: "//button[contains(text(),'6 hours')]")
  button(:eight_hours_duration, xpath: "//button[contains(text(),'8 hours')]")

  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  # elements(:form_structure, xpath: "//div/*[local-name()='span' or local-name()='label' or local-name()='p' and not(contains(text(),'PRE/TEMP/'))]")
  elements(:form_structure, xpath: "//div[contains(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span")
  text_field(:reporting_interval, xpath: "//input[@id='pre_section2_reportingIntervalPeriod']")
  element(:pre_creator_form, xpath: "//div[contains(@class,'Cell__Description')][1]")
  
  @@radio_buttons = "//span[contains(text(),'%s')]/following::*[1]/label" # for questions
  @@interval_period_id = 'pre_section2_reportingIntervalPeriod'

  @@pending_approval_pre_link = "//strong[contains(text(),'Pump Room Entry Permit')]//following::a[1]"
  @@scheduled_link = "//strong[contains(text(),'Pump Room Entry Permit')]//following::a[2]"
  @@active_link = "//strong[contains(text(),'Pump Room Entry Permit')]/parent::span"
  @@activity_pre_text = "//*[contains(text(),'Pump Room Entry Permit')]/parent::span"

  ### gx
  button(:approve_activation, xpath: "//button[contains(.,'Approve for Activation')]")
  element(:pump_room_display_setting, xpath: "//span[contains(.,'Pump Room')]")
  text_area(:purpose_of_entry, xpath: "//textarea[@id='reasonForEntry']")
  span(:entrant_names_dd, xpath: "//span[contains(.,'Select Other Entrants - Optional')]")
  @@button = "//button[contains(.,'%s')]"
  elements(:entry_log_table, xpath: "//div[@data-testid='entry-log-column']/div")
  element(:permit_end_time, xpath: "//section[contains(@class,'Section__SectionMain')][23]/div/div[2]/p")
  element(:permit_start_time, xpath: "//section[contains(@class,'Section__SectionMain')][23]/div/div[1]/p")
  ### end

  def get_validity_start_and_end_time
    @@pre_permit_start_time = permit_start_time_element.text
    @@pre_permit_end_time = permit_end_time_element.text
  end

  def get_entry_log_validity_details
    "#{@@pre_permit_start_time[12,5]} - #{@@pre_permit_end_time[12,5]}"
  end

  def signout_entrant(_entrants)
    sleep 1
    # sign_out_btn_elements.first.click
    BrowserActions.poll_exists_and_click(sign_out_btn_elements.first)
    (1.._entrants.to_i).each do |_i|
      cross_btn_elements[_i].click
      sleep 1
      # sign_out_btn_elements.last.click
      BrowserActions.poll_exists_and_click(sign_out_btn_elements.last)
    end
    sleep 1
    set_current_time
  end

  def additional_entrant(_additional_entrants)
    purpose_of_entry="Test Automation"
    entrant_names_dd_element.click
    sleep 2
    while _additional_entrants > 0
      member_name_btn_elements[_additional_entrants].click
      _additional_entrants = _additional_entrants - 1
    end
    confirm_btn_elements.first.click
  end

  def add_all_gas_readings_pre(_o2,_hc,_h2s,_co,_gas_name,_threhold,_reading,_unit)
    normal_gas_readings(_o2,_hc,_h2s,_co)
    sleep 1
    toxic_gas_readings(_gas_name,_threhold,_reading,_unit)
  end

  def fill_up_pre(duration)
    fill_static_pre
    select_permit_duration(duration)
  end

  def fill_static_pre
    fill_text_area(@@text_areas, 'Test Automation')
    select_checkbox(@@radio_buttons%["Location of vessel"], ['At Sea', 'In Port'].sample)
  end

  def select_start_time_to_activate(delay)
    set_current_time
    hh, mm = add_minutes(delay)

    picker = "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']"
    picker_hh = "//div[@class='time-picker']//div[starts-with(@class,'picker')][1]//*[contains(text(),'%s')]" % [hh]
    picker_mm = "//div[@class='time-picker']//div[starts-with(@class,'picker')][2]//*[contains(text(),'%s')]" % [mm]

    sleep 1
    @browser.find_element(:xpath, picker).click
    sleep 1
    BrowserActions.scroll_down
    BrowserActions.scroll_down
    @browser.find_element(:xpath, picker_hh).click
    sleep 1
    @browser.find_element(:xpath, picker_mm).click
    sleep 1
    BrowserActions.js_click("//h2[contains(text(),'Permit Validity')]")
  end


  def press_button_for_current_PRE(button)
    xpath_str = "//span[contains(text(),'%s')]//following::span[contains(text(),'%s')][1]"%[@@pre_number, button]
    @browser.find_element(:xpath, xpath_str).click
  end

  def are_questions?(table)
    table.all? do |question|
      is_element_displayed?("xpath", question[0], 'text')
    end
  end

  def has_three_types_answers?(table)
    table.all? do |question|
      xpath_str = @@radio_buttons % [question[0]]
      elements = $browser.find_elements('xpath', xpath_str)
      elements.size === 3
    end
  end
  
  def is_text_displayed?(like,_value)
    if like == "alert_text"
      xpath = "//div[contains(.,'%s')]"
      # value = alert_text % [_value]
    elsif like == "text"
      xpath = "//*[contains(text(),'%s')]"
      # value = any_text % [_value]
    elsif like == "auto_terminated"
      xpath = "//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]"# % [_value]
    elsif ((like == "label") || (like == "page"))
      xpath = "//h3[contains(text(),'%s')]"# % [_value]
    elsif like == "button"
      xpath = @@button
    end
    is_element_displayed(xpath,_value)
  end

  def is_alert_text_displayed?(_value)
    is_element_displayed("//div[contains(.,'%s')]",_value)
  end
  
  def is_auto_terminated_displayed?(_value)
    is_element_displayed("//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]",_value)
  end
  # def is_element_displayed?(by, value, like = "", fast = nil)
  #   if like == "alert_text"
  #     alert_text = "//div[contains(.,'%s')]"
  #     value = alert_text % [value]
  #   elsif like == "text"
  #     any_text = "//*[contains(text(),'%s')]"
  #     value = any_text % [value]
  #   elsif like == "auto_terminated"
      # value = "//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]" % [value]
  #   elsif like == "label"
  #     value = "//h3[contains(text(),'%s')]" % [value]
  #   elsif like == "button"
  #     value = @@button % [value]
  #   end

  #   if fast.nil?
  #     @browser.find_element(by, value)#.displayed?
      
  #   else
  #     js = %(return document.evaluate("%s", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue) % [value]
  #     !@browser.execute_script(js).nil?
  #   end
  # rescue StandardError
  #   false
  # end

  def select_permit_duration(duration)
    BrowserActions.scroll_click(permit_validation_btn_element)
    scroll_multiple_times(5)
    sleep 1
    case duration.to_i
    when 4
      four_hours_duration
    when 6
      six_hours_duration
    when 8
      eight_hours_duration
    end
  end

  def is_button_enabled?(button_text)
    xpath_str = @@button % [button_text]
    el = @browser.find_element('xpath', xpath_str)
    BrowserActions.scroll_down(el)
    BrowserActions.scroll_down
    el.enabled?
  end


  def select_answer(answer, question)
    xpath_str = @@radio_buttons % [question]
    select_checkbox(xpath_str, answer)
  end

  def press_the_button(button)
    xpath_str = @@button % [button]
    el = @browser.find_element("xpath", xpath_str)
    BrowserActions.scroll_click(el)

  end

  def fill_text_input(type, selector, text)
    @browser.find_element(type, selector).send_keys(text)
  end

  def check_filled_data?(type, selector, test_data)
    @browser.find_element(type, selector).value == test_data
  end

  def reduce_time_activity( finish_in_x_minutes)
    p "permit no: >> #{@@pre_number}"
    time_to_finish = get_current_time+60*finish_in_x_minutes
    web_pre_id = @@pre_number.gsub('/', '%2F')
    url = "#{EnvironmentSelector.get_graphql_environment_url('fauxton_url')}/forms/%s?conflicts=true"
    url = url % [web_pre_id]
    p "url >> #{url}"

    request = HTTParty.get(url, {
        headers: {'Content-Type': 'application/json'}})

    p "request >> #{request}"
    
    full_form = (JSON.parse request.to_s)
    full_form['answers']['permitValidUntil']['value']['dateTime'] = Time.at(time_to_finish).utc.strftime('%Y-%m-%dT%H:%M:%S.001Z')

    request = HTTParty.put(url, {
        headers: {'Content-Type': 'application/json'},
        body: full_form.to_json})
    (JSON.parse request.to_s)
  end

  private

  def is_element_displayed(_xpath,_value=nil)
    begin
      # alert_text = "//div[contains(.,'%s')]"
      value = _xpath % [_value]
      @browser.find_element('xpath', value).displayed?
    rescue
      false
    end
  end

  def get_current_time
      @which_json = 'ship-local-time/base-get-current-time'
      ServiceUtil.post_graph_ql(@which_json, '1111')
      ServiceUtil.get_response_body['data']['currentTime']["secondsSinceEpoch"]
  end

  def add_minutes(add_mm)
    hh, mm = @@time.split(":")
    mm = mm.to_i
    hh = hh.to_i

    mm = mm+add_mm.to_i
    if mm >= 60
      mm = mm-60
      hh = hh+1
    end
    return format('%02d', hh), format('%02d', mm)
  end
end
