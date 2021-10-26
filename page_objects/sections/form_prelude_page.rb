# frozen_string_literal: true

require_relative '../base_page'

# FormPreludePage object
class FormPreludePage < BasePage
  FORM_PRELUDE = {
    section_header: "//h3[contains(.,'Select Permit Type')]",
    dropdown_list: '//button[contains(.,"Select")]',
    permit_option: '//button[contains(.,"%s")]',
    save_btn: '//button[contains(.,"Save & Next")]',
    back_btn: '//button[contains(.,"Back")]',
    close_btn: '//button[contains(.,"Close")]',
    permit_type_list: "div[role='dialog'] > div:nth-child(2) > div > ul > li > button"
  }.freeze

  TWO_LEVEL_PERMITS = ['Cold Work', 'Critical Equipment Maintenance', 'Hot Work', 'Rotational Portable Power Tools',
                       'Underwater Operations'].freeze

  def initialize(driver)
    super
    find_element(FORM_PRELUDE[:section_header])
  end

  def select_level1_permit(permit)
    click(FORM_PRELUDE[:dropdown_list])
    scroll_click(FORM_PRELUDE[:permit_option] % permit)
    click(FORM_PRELUDE[:save_btn]) unless TWO_LEVEL_PERMITS.include? permit
  end

  def select_level2_permit(permit)
    scroll_click(FORM_PRELUDE[:permit_option] % permit)
    click(FORM_PRELUDE[:save_btn])
  end

  def back_to_permit_selection
    click(FORM_PRELUDE[:back_btn])
    click(FORM_PRELUDE[:close_btn])
  end

  def verify_level1_list(table)
    click(FORM_PRELUDE[:dropdown_list])
    level1_elements = @driver.find_elements(css: FORM_PRELUDE[:permit_type_list])
    WAIT.until { level1_elements.size.positive? }
    table.raw.each_with_index do |item, index|
      WAIT.until { level1_elements[index].displayed? }
      compare_string(item.first, level1_elements[index].text)
    end
  end

  def verify_level2_list(permit)
    expected_list = YAML.load_file('data/permit_types.yml')[permit]
    element_list = @driver.find_elements(css: FORM_PRELUDE[:permit_type_list])
    WAIT.until { element_list.size.positive? }
    element_list.each_with_index do |element, index|
      WAIT.until { element.displayed? }
      compare_string(element.text, expected_list[index])
    end
  end
end
