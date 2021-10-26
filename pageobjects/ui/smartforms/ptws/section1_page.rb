# frozen_string_literal: true

require './././features/support/env'

class Section1Page < Section0Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  elements(:all_labels, xpath: '//label')
  buttons(:btn_list, xpath: "//nav[starts-with(@class,'FormNavigationFactory__Button')]/button")
  buttons(:duration_btn, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  button(:sea_state_btn, xpath: '//button[@id="seaState"]')
  button(:zone_btn, xpath: '//button[@id="zone"]')
  button(:wind_force_btn, xpath: '//button[@id="windforce"]')
  elements(:dd_list_value, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  element(:s1_navigation_dropdown, xpath: "//h3[contains(.,'Section 1: Task Description')]")
  text_field(:zone_details_input, xpath: '//input[@id="zone-details"]')

  @@maint_require_text = '//div[@id="1_6"]'
  @@maint_duration_dd = '//button[@id="duration_of_maintenance_over_2_hours"]'

  @@location_check_btn = "//span[contains(.,'%s')]"
  @@condition_check_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')][2]/div/label"
  @@text_areas = '//textarea'

  def set_section1_filled_data(entered_pin, create_or_submitted)
    rank_and_name = get_user_details_by_pin(entered_pin)
    @@section1_data_collector << "#{create_or_submitted} #{rank_and_name[0]} #{rank_and_name[1]} #{rank_and_name[2]} at"
    sleep 1
    @@section1_data_collector << get_current_date_and_time.to_s
    Log.instance.info(@@section1_data_collector)
    @@section1_data_collector
  end

  def get_filled_section1
    sleep 1
    tmp = []
    tmp << generic_data_elements[0].text
    tmp << generic_data_elements[1].text
    tmp << generic_data_elements[2].text
    tmp << generic_data_elements[3].text
    tmp << generic_data_elements[4].text
    tmp << generic_data_elements[5].text
    tmp << generic_data_elements[6].text
    tmp << generic_data_elements[7].text
    tmp << generic_data_elements[8].text
    tmp << generic_data_elements[9].text
    tmp
  end

  def maint_duration_dd_exists?
    element = @browser.find_element(:xpath, @@maint_require_text)
    BrowserActions.scroll_down(element)
    element.text == 'Please answer question `Will the duration of this Maintenance be over 2 hours` before continuing.'
  rescue StandardError
    false
  end

  def sea_states?(table)
    get_dd_list_values(sea_state_btn_element) == serialize_table_input(table)
  end

  def wind_forces?(table)
    get_dd_list_values(wind_force_btn_element) == serialize_table_input(table)
  end

  def set_maintenance_duration(condition)
    @browser.find_element(:xpath, @@maint_duration_dd).click
    if condition == 'more'
      BrowserActions.scroll_click(dd_list_value_elements[0])
    else
      BrowserActions.scroll_click(dd_list_value_elements[1])
    end
  end

  def fill_partial_section1
    sleep 1
    set_default_section1
  end

  def fill_default_section1
    sleep 2
    set_default_section1
    select_location_of_work
  end

  def select_location_of_work
    sleep 1
    BrowserActions.scroll_click(zone_btn_element)
    BrowserActions.scroll_click(dd_list_value_elements.first)
    BrowserActions.scroll_click(dd_list_value_elements.first)
    sleep 1
  end

  private

  def select_sea_and_wind_state
    BrowserActions.scroll_click(sea_state_btn_element)
    BrowserActions.scroll_click(dd_list_value_elements[0])
    BrowserActions.scroll_click(wind_force_btn_element)
    BrowserActions.scroll_click(dd_list_value_elements[0])
  end

  def set_default_section1
    select_checkbox(@@location_check_btn, 'In Port')
    select_checkbox(@@condition_check_btn, 'Loaded')
    select_sea_and_wind_state
    fill_text_area(@@text_areas, 'Test Automation')
    zone_details_input_element.send_keys('Test Automation')
    sleep 5
    BrowserActions.hide_keyboard
  end

  def select_checkbox(input, location)
    sleep 1
    BrowserActions.js_click(format(input, location).to_s)
  end

  def fill_text_area(input, text)
    tmp_elements = @browser.find_elements(:xpath, input)
    tmp_elements.each do |element|
      element.send_keys(text)
    end
  end

  def serialize_table_input(table)
    serialized_input = []
    table.each do |input|
      serialized_input << input.first
    end
    serialized_input
  end

  def get_dd_list_values(states)
    sleep 1
    BrowserActions.scroll_click(states)
    drop_down_list_values = []
    dd_list_value_elements.each do |elem|
      BrowserActions.scroll_down(elem)
      drop_down_list_values << elem.text
    end
    p ">>> #{drop_down_list_values}"
    drop_down_list_values
  end

  def get_user_details_by_pin(entered_pin)
    tmp_payload = JSON.parse JsonUtil.read_json('get_user_detail_by_pin')
    tmp_payload['variables']['pin'] = entered_pin.to_s
    JsonUtil.create_request_file('mod_get_user_detail_by_pin', tmp_payload)
    ServiceUtil.post_graph_ql('mod_get_user_detail_by_pin')
    tmp_arr = []
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['rank']
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['firstName']
    tmp_arr << ServiceUtil.get_response_body['data']['validatePin']['crewMember']['lastName']
    tmp_arr
  end
end
