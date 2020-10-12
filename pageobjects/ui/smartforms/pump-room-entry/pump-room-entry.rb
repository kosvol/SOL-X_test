require './././support/env'

class PumpRoomEntry < Section9Page
  include PageObject
  include GasReading

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  element(:current_activity_pre, xpath: "//*[contains(text(),'Pump Room Entry Permit')]/parent::span")
  element(:pre_id, xpath: "//h4[contains(text(),'PRE No:')]/following::p")
  button(:create_new_pre_btn, xpath: "//span[contains(text(),'Create New Pump Room Entry Permit')]//..")
  button(:permit_validation_btn, xpath: "//button[@id='permitValidDuration']")
  button(:current_day_button_btn, xpath: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]")

  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")

  @@text_areas = '//textarea'
  @@permit_duration = "//button[contains(text(),'%s')]"
  @@button = "//span[contains(text(),'%s')]//.."
  @@radio_buttons = "//span[contains(text(),'%s')]/following::*[1]/label" # for questions
  @@interval_period_id = 'pre_section2_reportingIntervalPeriod'


  @@pending_approval_pre_link = "//strong[contains(text(),'Pump Room Entry Permit')]//following::a[1]"
  @@scheduled_link = "//strong[contains(text(),'Pump Room Entry Permit')]//following::a[2]"
  @@active_link = "//strong[contains(text(),'Pump Room Entry Permit')]/parent::span"
  @@activity_pre_text = "//*[contains(text(),'Pump Room Entry Permit')]/parent::span"


  def fill_up_pre(duration)
    fill_static_pre
    select_permit_duration(duration)
  end

  def fill_static_pre
    fill_text_area(@@text_areas, 'Test Automation')
    select_checkbox(@@radio_buttons%["Location of vesse"], ['At Sea', 'In Port'].sample)
  end

  def select_start_time_to_activate(delay)
    set_current_time #@@time
    hh, mm = add_minutes(delay)

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
    x = %(document.evaluate("//h2[contains(text(),'Permit Validity')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click())
    @browser.execute_script(x)  #click on empty space to close picker
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

  def is_element_displayed?(by, value, like = "", fast = nil)
    if like == "alert_text"
      alert_text = "//div[contains(.,'%s')]"
      value = alert_text % [value]
    elsif like == "text"
      any_text = "//*[contains(text(),'%s')]"
      value = any_text % [value]
    elsif like == "auto_terminated"
      value = "//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]" % [value]
    elsif like == "label"
      value = "//h3[contains(text(),'%s')]" % [value]
    elsif like == "button"
      value = @@button % [value]
    end

    if fast.nil?
      @browser.find_element(by, value).displayed?
    else
      js = %(return document.evaluate("%s", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue) % [value]
      !@browser.execute_script(js).nil?
    end
  rescue StandardError
    false
  end

  def select_permit_duration(duration)
    BrowserActions.scroll_click(permit_validation_btn_element)
    sleep 1
    BrowserActions.scroll_down
    xpath_str = @@permit_duration % [duration]
    @browser.find_element('xpath', xpath_str).click
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

    time_to_finish = get_current_time+60*finish_in_x_minutes
    web_pre_id = @@pre_number.gsub('/', '%2F')
    url = "http://admin:magellanx@cloud-edge.stage.solas.magellanx.io:5984/forms/%s?conflicts=true"
    url = url % [web_pre_id]

    request = HTTParty.get(url, {
        headers: {}})
    full_form = (JSON.parse request.to_s)

    full_form['answers']['permitValidUntil']['value']['dateTime'] = Time.at(time_to_finish).utc.strftime('%Y-%m-%dT%H:%M:%S.001Z')

    request = HTTParty.put(url, {
        headers: {'Content-Type': 'application/json'},
        body: full_form.to_json})
    (JSON.parse request.to_s)
  end

  def navigate_for_pre(item)
    if item === "Active PRE"
      @browser.find_element(:xpath, @@active_link).click
    elsif item === "Scheduled"
      @browser.find_element(:xpath, @@scheduled_link).click
    elsif item === "Pending approval PRE"
      @browser.find_element(:xpath, @@pending_approval_pre_link).click
    end
  end

  private

  def get_current_time
      @which_json = 'ship-local-time/base-get-current-time'
      ServiceUtil.post_graph_ql(@which_json, '1111')
      ServiceUtil.get_response_body['data']['currentTime']["secondsSinceEpoch"]
  end

  def add_minutes(add_mm)
    hh, mm = @@time.split(":")
    mm = mm.to_i
    hh = hh.to_i

    mm = mm+add_mm
    if mm >= 60
      mm = mm-60
      hh = hh+1
    end
    return format('%02d', hh), format('%02d', mm)
  end
end
