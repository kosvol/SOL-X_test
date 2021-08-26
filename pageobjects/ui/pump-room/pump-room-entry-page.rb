require '././support/env'

class PumpRoomEntry < PreDisplay
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  element(:current_activity_pre, xpath: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span")
  element(:pre_id, xpath: "//h4[contains(text(),'PRE No:')]/following::p")
  element(:create_new_pre_btn, xpath: "//span[contains(.,'Pump Room')]")
  element(:create_new_cre_btn, xpath: "//span[contains(.,'Compressor/Motor')]")
  button(:permit_validation_btn, xpath: "//button[@id='permitValidDuration']")
  button(:current_day_button_btn, xpath: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]")
  button(:four_hours_duration, xpath: "//button[contains(.,'4 hours')]")
  button(:six_hours_duration, xpath: "//button[contains(text(),'6 hours')]")
  button(:eight_hours_duration, xpath: "//button[contains(text(),'8 hours')]")
  elements(:cre_scrap, xpath: "//div/*/*[local-name()='span' or local-name()='label']")

  # elements(:form_structure, xpath: "//div/*[local-name()='span' or local-name()='label' or local-name()='p' and not(contains(text(),'PRE/TEMP/'))]")
  elements(:form_structure, xpath: "//div[contains(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span")
  text_field(:reporting_interval, xpath: "//input[@id='pre_section2_reportingIntervalPeriod']")
  element(:pre_creator_form, xpath: "//div[contains(@class,'Cell__Description')][1]")
  elements(:person_checkbox, xpath: "//span[@class='checkbox']")
  element(:enter_pin_and_apply, xpath: '//button[@class="Button__ButtonStyled-w803xw-0 geNOWa"]')

  @@radio_buttons = "//span[contains(text(),'%s')]/following::*[1]/label" # for questions
  @@interval_period_id = 'pre_section2_reportingIntervalPeriod'

  @@pending_approval_pre_link = "//strong[contains(text(),'Pump Room Entry Permit')]//following::a[1]"
  @@scheduled_link = "//strong[contains(text(),'Pump Room Entry Permit')]//following::a[2]"
  @@active_link = "//strong[contains(text(),'Pump Room Entry Permit')]/parent::span"
  @@activity_pre_text = "//*[contains(text(),'Pump Room Entry Permit')]/parent::span"
  @@entrants_arr = []
  element(:view_btn, xpath: "//button[contains(.,'View')]")
  element(:entrant_select_btn, xpath: "//span[contains(text(),'Select Entrants - Required')]")
  element(:entry_log_btn, xpath: "//*[starts-with(@class,'TabNavigator__TabItem')][2]/a/span")
  element(:input_field, xpath: "//div[starts-with(@class,'Input')]")
  element(:resp_off_signature, xpath: "//h2[contains(.,'Responsible Officer Signature:')]")
  elements(:resp_off_signature_rank, xpath: "//h3[contains(.,'Rank/Name')]")
  @@element_value = "//div[contains(.,'%s')]"
  ### gx
  elements(:signed_in_entrants, xpath: '//div/div/ul/li')
  button(:approve_activation, xpath: "//button[contains(.,'Approve for Activation')]")
  element(:pump_room_display_setting, xpath: "//span[contains(.,'Pump Room')]")
  element(:compressor_room_display_setting, xpath: "//span[contains(.,'Compressor/Motor Room')]")
  element(:smartforms_display_setting, xpath: "//span[contains(.,'SmartForms')]")
  text_area(:purpose_of_entry, xpath: "//textarea[@id='reasonForEntry']")
  element(:entrant_names_dd, xpath: "//span[contains(.,'Select Other Entrants - Optional')]")
  @@button = "//button[contains(.,'%s')]"
  elements(:entry_log_table, xpath: "//div[@data-testid='entry-log-column']/div")
  element(:permit_end_time, xpath: "//section[contains(@class,'Section__SectionMain')][23]/div/div[2]/p")
  element(:permit_start_time, xpath: "//section[contains(@class,'Section__SectionMain')][23]/div/div[1]/p")
  element(:permit_start_time1, xpath: "//section[contains(@class,'Section__SectionMain')][13]/div/div[1]/p")
  element(:permit_end_time1, xpath: "//section[contains(@class,'Section__SectionMain')][13]/div/div[2]/p")
  element(:input_field1, xpath: "//input[starts-with(@class,'Input')]")
  elements(:header_cell, xpath: "//div[starts-with(@class,'header-cell')]")
  elements(:header_pwt, xpath: "//h4[starts-with(@class,'Heading__H4')]")
  element(:gas_O2, xpath: "//div[contains(.,'O2')]")
  element(:gas_HC, xpath: "//div[contains(.,'HC')]")
  element(:gas_H2S, xpath: "//div[contains(.,'H2S')]")
  elements(:list_name, xpath: "//div[starts-with(.,'EntrantListItem__ListItem')]")
  element(:show_signature_display, xpath: "//button[@data-testid='show-signature-display']")
  ### end
  @@selected_date = nil

  def get_validity_start_and_end_time(permit_type)
    case permit_type
    when 'CRE'
      @@pre_permit_start_time = permit_start_time1_element.text
      @@pre_permit_end_time = permit_end_time1_element.text
    when 'PRE'
      @@pre_permit_start_time = permit_start_time_element.text
      @@pre_permit_end_time = permit_end_time_element.text
    end
  end

  def get_entry_log_validity_start_details
    "#{@@pre_permit_start_time[12, 5]}"
  end

  def get_entry_log_validity_end_details
    "#{@@pre_permit_end_time[12, 5]}"
  end

  def set_entrants(entrants)
    @@entrants_arr = entrants
  end

  def get_entrants()
    @@entrants_arr
  end

  def signout_entrant(_entrants)
    sleep 1
    BrowserActions.poll_exists_and_click(sign_out_btn_elements.first)
    (1.._entrants.to_i).each do |_i|
      cross_btn_elements[_i].click
      sleep 1
      BrowserActions.poll_exists_and_click(sign_out_btn_elements.last)
    end
    sleep 1
    set_current_time
  end

  def signout_entrant_by_name(_entrants)
    sleep 1
    entrants_arr = get_entrants
    BrowserActions.poll_exists_and_click(sign_out_btn_elements.first)
    _entrants.split(',').each do |_i|
      puts (_entrants.index(_i))
      find_element(:xpath,
                   "//*[contains(.,'#{_i}')]/button").click
      sleep 1
      BrowserActions.poll_exists_and_click(sign_out_btn_elements.last)
      entrants_arr.delete(_i)
    end
    set_entrants(entrants_arr)
    sleep 1
    set_current_time
  end

  def is_entered_entrant_listed?(entrant)
    entrant_names_dd_element.click
    sleep 1
    options_text_elements.each do |_crew|
      if entrant === _crew.text
        return false
      end
    end
    return true
  end

  def additional_entrant(_additional_entrants)
    entr_arr = []
    purpose_of_entry = 'Test Automation'
    puts entrant_names_dd_element.text
    entrant_names_dd_element.click
    sleep 2
    while _additional_entrants > 0
      options_text_elements[_additional_entrants].click
      entr_arr.push(options_text_elements[_additional_entrants].text)
      _additional_entrants = _additional_entrants - 1
    end
    set_entrants(entr_arr)
    confirm_btn_elements.first.click
  end

  def required_entrants(entrants)
    entr_arr = []
    while entrants > 0
      puts(person_checkbox_elements.size)
      #person_checkbox_elements[entrants].click
      $browser.find_element(:xpath,
                            "//*[starts-with(@class,'UnorderedList')]/li[#{entrants + 1}]/label/label/span").click
      entr_arr.push($browser.
        find_element(:xpath,
                     "//*[starts-with(@class,'UnorderedList')]/li[#{entrants + 1}]/label/div").text)
      entrants = entrants - 1
    end
    set_entrants(entr_arr)
  end

  def add_all_gas_readings_pre(_o2, _hc, _h2s, _co, _gas_name, _threhold, _reading, _unit)
    if _gas_name === '' or _threhold === '' or _reading === '' or _unit === ''
      normal_gas_readings(_o2, _hc, _h2s, _co)
    else
      normal_gas_readings(_o2, _hc, _h2s, _co)
      sleep 1
      toxic_gas_readings(_gas_name, _threhold, _reading, _unit)
    end
  end

  def fill_up_pre(duration)
    fill_static_pre
    select_permit_duration(duration)
  end

  def fill_static_pre
    fill_text_area(@@text_areas, 'Test Automation')
    select_checkbox(@@location_check_btn, ['At Sea', 'In Port'].sample)
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

  def select_day(_condition, _number, _point)
    picker = "//label[contains(text(),'Start Time')]//following::button[@data-testid='days']"
    selected_current_day = "//*[contains(@class,'selected current')]"
    selected_day = "//*[contains(@class,'selected')]"
    current_day_date = "//*[contains(@class,'current')]"
    @browser.find_element(:xpath, picker).click
    sleep 1
    if @@selected_date === nil
      current_day = @browser.find_element(:xpath, selected_current_day).text
      @@selected_date = current_day.to_i + _number.to_i
    else
      if _point === 'current'
        current_day = @browser.find_element(:xpath, current_day_date).text
      else
        current_day = @browser.find_element(:xpath, selected_day).text
      end
    end
    sleep 1
    changed_day = "//div[starts-with(@class,'DatePicker__OverlayContainer')]//button[contains(.,'#{(current_day.to_i + _number.to_i)}')]" if _condition === 'Future'
    changed_day = format("//div[starts-with(@class,'DatePicker__OverlayContainer')]//*[contains(text(),'%s')]", (current_day.to_i - _number.to_i)) if _condition === 'Past'
    sleep 1
    @browser.find_element(:xpath, changed_day).click
    sleep 1
    BrowserActions.js_click("//h2[contains(text(),'Permit Validity')]")
  end

  def press_button_for_current_PRE(button)
    xpath_str = "//span[contains(text(),'%s')]//following::span[contains(text(),'%s')][1]" % [@@pre_number, button]
    @browser.find_element(:xpath, xpath_str).click
  end

  def compare_scheduled_date
    #//*[@id="root"]/div/ul/li/div[2]/div/div[2]/span[2]
    xpath_str = "//*[contains(.,'Scheduled for')]/parent::*//span[1]" % [@@pre_number]
    text = @browser.find_element(:xpath, xpath_str).text
    text.include? @@selected_date.to_s
  end

  def are_questions?(table)
    table.all? do |question|
      is_element_displayed?('xpath', question[0], 'text')
    end
  end

  def has_three_types_answers?(table)
    table.all? do |question|
      xpath_str = @@radio_buttons % [question[0]]
      elements = $browser.find_elements('xpath', xpath_str)
      elements.size === 3
    end
  end

  def is_text_displayed?(like, _value)
    if like == 'alert_text'
      xpath = "//div[contains(.,'%s')]"
    elsif like == 'text'
      xpath = "//*[contains(text(),'%s')]"
    elsif like == 'auto_terminated'
      xpath = "//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]"
    elsif ((like == 'label') || (like == 'page'))
      xpath = "//h2[contains(text(),'%s')]"
    elsif like == 'header'
      xpath = "//h1[contains(text(),'%s')]"
    elsif like == 'button'
      xpath = @@button
    end
    is_element_displayed(xpath, _value)
  end

  def is_alert_text_displayed?(_value)
    is_element_displayed("//div[contains(.,'%s')]", _value)
  end

  def is_auto_terminated_displayed?(_value)
    is_element_displayed("//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]", _value)
  end

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
    el = @browser.find_element('xpath', xpath_str)
    BrowserActions.scroll_click(el)
  end

  def fill_text_input(type, selector, text)
    @browser.find_element(type, selector).send_keys(text)
  end

  def check_filled_data?(type, selector, test_data)
    @browser.find_element(type, selector).value == test_data
  end

  def reduce_time_activity(finish_in_x_minutes)
    p "permit no: >> #{@@pre_number}"
    time_to_finish = get_current_time + 60 * finish_in_x_minutes
    web_pre_id = @@pre_number.gsub('/', '%2F')
    url = EnvironmentSelector.get_edge_db_data_by_uri('forms/%s?conflicts=true')
    url = url % [web_pre_id]
    p "url >> #{url}"

    request = HTTParty.get(url, {
      headers: { 'Content-Type': 'application/json' },
    })

    p "request >> #{request}"

    full_form = (JSON.parse request.to_s)
    full_form['answers']['permitValidUntil']['value']['dateTime'] = Time.at(time_to_finish).utc.strftime('%Y-%m-%dT%H:%M:%S.001Z')

    request = HTTParty.put(url, {
      headers: { 'Content-Type': 'application/json' },
      body: full_form.to_json,
    })
    (JSON.parse request.to_s)
  end

  def get_element_by_value(_element_value_text, _count)
    xpath_str = @@element_value % [_element_value_text]
    el_arr = @browser.find_elements('xpath', xpath_str)
    return el_arr[_count.to_i]
  end

  private

  def is_element_displayed(_xpath, _value = nil)
    begin
      value = _xpath % [_value]
      @browser.find_element('xpath', value).displayed?
    rescue
      false
    end
  end

  def get_current_time
    @which_json = 'ship-local-time/base-get-current-time'
    ServiceUtil.post_graph_ql(@which_json, '1111')
    ServiceUtil.get_response_body['data']['currentTime']['secondsSinceEpoch']
  end

  def add_minutes(add_mm)
    hh, mm = @@time.split(':')
    mm = mm.to_i
    hh = hh.to_i

    mm = mm + add_mm.to_i
    if mm >= 60
      mm = mm - 60
      hh = hh + 1
    end
    return format('%02d', hh), format('%02d', mm)
  end
end
