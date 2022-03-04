# frozen_string_literal: true

require_relative '../base_page'

# SectionFourAPage object
class SectionFourAPage < BasePage
  include EnvUtils
  SECTION_FOUR_A = {
    section_header: "//h3[contains(.,'Section 4A: Safety Checklist')]",
    checklist_na_button: "//*[@type='radio' and @value='na']",
    checklist_yes_button: "//*[@type='radio' and @value='yes']",
    form_fields: "//div[starts-with(@class, 'FormFieldCheckButtonGroupFactory')]/div/span"
  }.freeze

  CHECKLIST_NAME_MAP = {
    work_on_hazard_our_substances: 'openChecklistWorkOnHazardousSubstances'
  }.freeze

  SELECTED_BACKGROUND = 'rgba(24, 144, 255, 1)'

  def initialize(driver)
    super
    find_element(SECTION_FOUR_A[:section_header])
  end

  def uncheck_all_checklist
    elements = find_elements(SECTION_FOUR_A[:checklist_na_button])
    elements.each do |element|
      @driver.execute_script('arguments[0].scrollIntoView({block: "center", inline: "center"})', element)
      element.click
    end
  end

  def select_checklist(checklist)
    scroll_click("//*[@name='#{CHECKLIST_NAME_MAP[checklist.to_sym]}' and @value='yes']")
  end

  def verify_checklist(table)
    checklist_elements = find_elements(SECTION_FOUR_A[:form_fields])
    checklist_elements.shift # remove page title 'Tool Box Meeting Carried Out'
    table.raw.each_with_index do |checklist, index|
      next if checklist_elements[index].text == 'Tool Box Meeting Carried Out'

      compare_string(checklist.first, checklist_elements[index].text)
    end
  end

  def verify_pre_selected(checklist)
    checklist_elements = find_elements(SECTION_FOUR_A[:form_fields])
    yes_elements = @driver.find_elements(:css, 'div > label:nth-child(1) > span')
    checklist_elements.each_with_index do |element, index|
      next unless element.text == checklist

      wait_selected_css(yes_elements[index])
    end
  end

  private

  def wait_selected_css(element)
    wait = 0
    until element.css_value('background-color') == SELECTED_BACKGROUND
      sleep 0.5
      wait += 1
      break if wait > 5
    end
  end
end
