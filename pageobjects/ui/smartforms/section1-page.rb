# frozen_string_literal: true

require './././support/env'

class Section1Page < Section0Page
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  elements(:all_labels, xpath: '//label')
  buttons(:btn_list, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button")
  buttons(:duration_btn, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  button(:sea_state_btn, xpath: '//button[@id="seaState"]')
  button(:wind_force_btn, xpath: '//button[@id="windforce"]')
  elements(:dd_list_value, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  @@maint_require_text = '//div[@id="1_subsection6"]'
  @@wind_forces = '//button[@id="windforce"]'
  @@list_of_dd_values = "//ul[starts-with(@class,'UnorderedList-')]/li/button"
  @@sea_states = '//button[@id="seaState"]'
  @@maint_duration_dd = '//button[@id="duration_of_maintenance_over_2_hours"]'
  @@location_check_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')][1]/div/label"
  @@condition_check_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')][2]/div/label"
  @@text_areas = '//textarea'

  def get_section1_filled_data
    @@section1_data_collector
  end

  def set_section1_filled_data
    # probably need to dynamic this created by
    @@section1_data_collector << 'Created By A/M Atif Hayat at'
    sleep 1
    @@section1_data_collector << "#{get_current_date_format_with_offset} #{get_current_time_format}"
    p ">>> #{@@section1_data_collector}"
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

  def is_fields_enabled?
    bool = true
    generic_data_elements.each do |field|
      bool &&= field.enabled?
    end
    bool
  rescue StandardError
    false
  end

  def is_maint_duration_dd_exists?
    _element = $browser.find_element(:xpath, @@maint_require_text)
    BrowserActions.scroll_down(_element)
    $browser.find_element(:xpath, @@maint_duration_dd)
    _element.text === 'Please answer question `Will the duration of this Maintenance be over 2 hours` before continuing.'
  rescue StandardError
    false
  end

  def is_sea_states?(_table)
    get_dd_list_values(@@sea_states, @@list_of_dd_values) === serialize_table_input(_table)
  end

  def is_wind_forces?(_table)
    get_dd_list_values(@@wind_forces, @@list_of_dd_values) === serialize_table_input(_table)
  end

  def fill_all_of_section_1_wo_duration
    fill_static_section1
    click_next
  end

  def fill_all_of_section_1_w_duration(_condition)
    fill_static_section1
    sleep 1
    $browser.find_element(:xpath, @@maint_duration_dd).click
    sleep 1
    _condition === 'more' ? dd_list_value_elements[0].click : dd_list_value_elements[1].click
    BrowserActions.scroll_click(click_next_element)
  end

  def fill_default_section_1_wo_duration
    fill_default_section1
    BrowserActions.scroll_click(click_next_element)
  end

  def fill_default_section_1_w_duration(_condition)
    fill_default_section1
    $browser.find_element(:xpath, @@maint_duration_dd).click
    sleep 1
    _condition === 'more' ? duration_btn_elements[0].click : duration_btn_elements[1].click
    BrowserActions.scroll_click(click_next_element)
  end

  private

  def fill_default_section1
    select_checkbox(@@location_check_btn, 'In Port')
    select_checkbox(@@condition_check_btn, 'Loaded')
    BrowserActions.scroll_click(sea_state_btn_element)
    dd_list_value_elements[0].click
    BrowserActions.scroll_click(wind_force_btn_element)
    dd_list_value_elements[0].click
    fill_text_area(@@text_areas, 'Test Automation')
    BrowserActions.hide_keyboard
  end

  def fill_static_section1
    select_checkbox(@@location_check_btn, ['At Sea', 'In Port', 'Anchorage'].sample)
    select_checkbox(@@condition_check_btn, %w[Loaded Ballast Other].sample)
    BrowserActions.scroll_click(sea_state_btn_element)
    sleep 1
    dd_list_value_elements[0].click
    BrowserActions.scroll_click(wind_force_btn_element)
    sleep 1
    dd_list_value_elements[0].click
    fill_text_area(@@text_areas, 'Test Automation')
    BrowserActions.hide_keyboard
  end

  def select_checkbox(_input, _location)
    _elements = $browser.find_elements(:xpath, _input)
    _elements.each do |element|
      if element.text === _location
        element.click
        break
      end
    end
  end

  def fill_text_area(_input, _text)
    tmp_elements = $browser.find_elements(:xpath, _input)
    tmp_elements.each do |_element|
      BrowserActions.scroll_click(_element)
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

  def get_dd_list_values(_states, _dd_list)
    sleep 1
    BrowserActions.scroll_down
    tmp_element = $browser.find_element(:xpath, _states)
    BrowserActions.scroll_click(tmp_element)
    _element = $browser.find_elements(:xpath, _dd_list)
    drop_down_list_values = []
    _element.each do |elem|
      BrowserActions.scroll_down(elem)
      drop_down_list_values << elem.text
    end
    p ">>> #{drop_down_list_values}"
    drop_down_list_values
  end
end
