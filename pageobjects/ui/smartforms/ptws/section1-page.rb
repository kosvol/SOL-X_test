# frozen_string_literal: true

require './././support/env'

class Section1Page < Section0Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  elements(:all_labels, xpath: '//label')
  buttons(:btn_list, xpath: "//nav[starts-with(@class,'FormNavigationFactory__Button')]/button")
  buttons(:duration_btn, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  button(:sea_state_btn, xpath: '//button[@id="seaState"]')
  button(:wind_force_btn, xpath: '//button[@id="windforce"]')
  elements(:dd_list_value, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  element(:s1_navigation_dropdown, xpath: "//h3[contains(.,'Section 1: Task Description')]")

  @@maint_require_text = '//div[@id="1_6"]'
  @@maint_duration_dd = '//button[@id="duration_of_maintenance_over_2_hours"]'
  
  @@location_check_btn = "//span[contains(.,'%s')]"
  @@condition_check_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')][2]/div/label"
  @@text_areas = '//textarea'

  def get_section1_filled_data
    @@section1_data_collector
  end

  def set_section1_filled_data
    # probably need to dynamic this created by
    @@section1_data_collector << 'Created By A/M Atif Hayat at'
    sleep 1
    @@section1_data_collector << get_current_date_and_time.to_s
    p ">>> #{@@section1_data_collector}"
    Log.instance.info(@@section1_data_collector)
    @@section1_data_collector
  end

  def get_filled_section1
    sleep 1
    tmp = []
    tmp << generic_data_elements[0].text
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

  # def is_fields_enabled?
  #   bool = true
  #   generic_data_elements.each do |field|
  #     bool &&= field.enabled?
  #   end
  #   bool
  # rescue StandardError
  #   false
  # end

  def is_maint_duration_dd_exists?
    _element = $browser.find_element(:xpath, @@maint_require_text)
    BrowserActions.scroll_down(_element)
    _element.text === 'Please answer question `Will the duration of this Maintenance be over 2 hours` before continuing.'
  rescue StandardError
    false
  end

  def is_sea_states?(_table)
    get_dd_list_values(sea_state_btn_element) === serialize_table_input(_table)
  end

  def is_wind_forces?(_table)
    get_dd_list_values(wind_force_btn_element) === serialize_table_input(_table)
  end

  def set_maintenance_duration(_condition)
    $browser.find_element(:xpath, @@maint_duration_dd).click
    _condition === 'more' ? BrowserActions.scroll_click(dd_list_value_elements[0]) : BrowserActions.scroll_click(dd_list_value_elements[1])
  end

  def fill_default_section_1
    sleep 2
    fill_default_section1
  end

  private

  def select_sea_and_wind_state
    BrowserActions.scroll_click(sea_state_btn_element)
    BrowserActions.scroll_click(dd_list_value_elements[0])
    BrowserActions.scroll_click(wind_force_btn_element)
    BrowserActions.scroll_click(dd_list_value_elements[0])
  end

  def fill_default_section1
    select_checkbox(@@location_check_btn, 'In Port')
    select_checkbox(@@condition_check_btn, 'Loaded')
    select_sea_and_wind_state
    fill_text_area(@@text_areas, 'Test Automation')
    BrowserActions.hide_keyboard
  end

  def select_checkbox(_input, _location)
    p ">> #{_input % [_location]}"
    BrowserActions.js_click("#{_input % [_location]}")
    # browser.execute_script(%(document.evaluate("#{_input % [_location]}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()))
  end

  def fill_text_area(_input, _text)
    tmp_elements = $browser.find_elements(:xpath, _input)
    tmp_elements.each do |_element|
      _element.send_keys(_text)
    end
  end

  def serialize_table_input(_table)
    serialized_input = []
    _table.each do |_input|
      serialized_input << _input.first
    end
    serialized_input
  end

  def get_dd_list_values(_states)
    sleep 1
    BrowserActions.scroll_click(_states)
    drop_down_list_values = []
    dd_list_value_elements.each do |_elem|
      BrowserActions.scroll_down(_elem)
      drop_down_list_values << _elem.text
    end
    p ">>> #{drop_down_list_values}"
    drop_down_list_values
  end
end
