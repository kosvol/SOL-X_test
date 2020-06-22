# frozen_string_literal: true

require './././support/env'

class Section1Page
  include PageObject

  @@wind_forces = '//button[@id="windforce"]'
  @@list_of_sea_states = "//ul[starts-with(@class,'UnorderedList-')]/li/button"
  @@sea_states = '//button[@id="seaState"]'

  def is_sea_states?(_table)
    get_dd_list_values(@@sea_states, @@list_of_sea_states) === serialize_table_input(_table)
  end

  def is_wind_forces?(_table)
    get_dd_list_values(@@wind_forces, @@list_of_sea_states) === serialize_table_input(_table)
  end

  private

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
