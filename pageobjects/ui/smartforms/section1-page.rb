# frozen_string_literal: true

require './././support/env'

class Section1Page
  include PageObject

  element(:heading_text, xpath: "//form[starts-with(@class,'FormFactory__Form')]/section/h2")
  buttons(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button")
  buttons(:duration_btn, xpath: "//ul[starts-with(@class,'UnorderedList-')]/li/button")
  @@previous_btns = "//div[starts-with(@class,'FormNavigationFactory__Button')]/button"
  @@maint_require_text = '//div[@id="1_subsection5"]'
  @@wind_forces = '//button[@id="windforce"]'
  @@list_of_dd_values = "//ul[starts-with(@class,'UnorderedList-')]/li/button"
  @@sea_states = '//button[@id="seaState"]'
  @@maint_duration_dd = '//button[@id="duration_of_maintenance_over_2_hours"]'
  @@location_check_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')][1]/div/label"
  @@condition_check_btn = "//div[starts-with(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')][2]/div/label"
  @@text_areas = '//textarea'

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
    BrowserActions.scroll_down($browser.find_elements(:xpath, @@previous_btns)[0])
    previous_btn_elements[1].click
  end

  def fill_all_of_section_1_w_duration(_condition)
    fill_static_section1
    BrowserActions.scroll_down($browser.find_element(:xpath, @@maint_require_text))
    $browser.find_element(:xpath, @@maint_duration_dd).click
    sleep 1
    _condition === 'more' ? duration_btn_elements[0].click : duration_btn_elements[1].click
    BrowserActions.scroll_down($browser.find_elements(:xpath, @@previous_btns)[0])
    previous_btn_elements[1].click
  end

  private

  def fill_static_section1
    select_checkbox(@@location_check_btn, ['At Sea', 'In Port', 'Anchorage'].sample)
    select_checkbox(@@condition_check_btn, %w[Loaded Ballast Other].sample)
    fill_text_area(@@text_areas, 'test')
  end

  def select_checkbox(_input, _location)
    _elements = $browser.find_elements(:xpath, _input)
    _elements.each do |element|
      BrowserActions.scroll_down(element)
      if element.text === _location
        element.click
        break
      end
    end
  end

  def fill_text_area(_input, _text)
    _elements = $browser.find_elements(:xpath, _input)
    _elements.each do |element|
      BrowserActions.scroll_down(element)
      element.send_keys(_text)
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
    _element = $browser.find_element(:xpath, _states)
    BrowserActions.scroll_down(_element)
    sleep 1
    _element.click
    sleep 1
    _element = $browser.find_elements(:xpath, _dd_list)
    list_of_sea_states = []
    _element.each do |elem|
      BrowserActions.scroll_down(elem)
      list_of_sea_states << elem.text
    end
    list_of_sea_states
  end
end
