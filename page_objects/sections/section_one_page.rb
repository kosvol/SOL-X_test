# frozen_string_literal: true

require_relative '../base_page'

# SectionOnePage object
class SectionOnePage < BasePage
  include EnvUtils
  SECTION_ONE = {
    section_header: "//h3[contains(.,'Section 1: Task Description')]",
    form_answers: "//*[starts-with(@class,'AnswerComponent__Answer')]",
    sea_state_btn: '//button[@id="seaState"]',
    wind_force_btn: '//button[@id="windforce"]',
    zone_btn: '//button[@id="zone"]',
    dd_list_value: "//ul[starts-with(@class,'UnorderedList-')]/li/button",
    duration_ddl: '//*[@id="duration_of_maintenance_over_2_hours"]',
    save_next_btn: "//button[contains(.,'Save & Next')]"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_ONE[:section_header])
  end

  def verify_permit_details(level1_permit)
    find_element(SECTION_ONE[:form_answers])
    elements = @driver.find_elements(xpath: SECTION_ONE[:form_answers])
    actual_vessel_name = elements[0].text
    actual_permit_type = elements[1].text
    compare_string(retrieve_vessel_name, actual_vessel_name)
    compare_string(level1_permit, actual_permit_type)
  end

  def verify_ddl_value(ddl_type, table)
    ddl_type == 'sea states' ? click(SECTION_ONE[:sea_state_btn]) : click(SECTION_ONE[:wind_force_btn])
    @driver.execute_script('window.scrollBy(0,300)', '') # need to scroll to pop up value
    dropdown_elements = @driver.find_elements(xpath: SECTION_ONE[:dd_list_value])
    table.raw.each_with_index do |item, index|
      WAIT.until { dropdown_elements[index].displayed? }
      compare_string(item.first, dropdown_elements[index].text)
    end
  end

  def verify_no_previous_btn
    verify_element_not_exist("//button[contains(.,'Previous')]")
  end

  def verify_duration_ddl(option)
    if option == 'should'
      find_element(SECTION_ONE[:duration_ddl])
    else
      verify_element_not_exist(SECTION_ONE[:duration_ddl])
    end
  end

  def click_save_next
    scroll_click(SECTION_ONE[:save_next_btn])
  end

  def answer_duration_maintenance(option)
    scroll_click(SECTION_ONE[:duration_ddl])
    @driver.execute_script('window.scrollTo(0, document.body.scrollHeight)')
    element = @driver.find_element(xpath: "//button[contains(.,'#{option}')]")
    WAIT.until { element.displayed? }
    element.click
  end
end
