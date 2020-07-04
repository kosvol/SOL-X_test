# frozen_string_literal: true

require './././support/env'

class Section4APage
  include PageObject

  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  elements(:yes_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]")
  @@yes_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]/span"
  elements(:no_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]")
  @@na_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]/span"
  spans(:checklist_name, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/span")

  # ##Blue rgba(24, 144, 255, 1)
  # ##White rgba(255, 255, 255, 1)
  def is_checklist_preselected(_checklist)
    element_yes = get_yes_elements
    # element_no = $browser.find_elements(:xpath, @@na_input)
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      # BrowserActions.scroll_down_by_dist
      return (element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)')
    end
  end

  def is_hazardous_substance_checklist
    element_yes = get_yes_elements
    # element_no = $browser.find_elements(:xpath, @@na_input)
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === 'Work on Hazardous Substances'

      BrowserActions.scroll_down(element_yes[_index])
      # BrowserActions.scroll_down_by_dist
      return (checklist.text === 'Work on Hazardous Substances') && (element_yes[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)') && (get_na_elements[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)')
    end
  end

  def select_checklist(_checklist)
    element_yes = get_yes_elements
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      element_yes[_index].click
    end
  end

  private

  def get_yes_elements
    $browser.find_elements(:xpath, @@yes_input)
  end

  def get_na_elements
    $browser.find_elements(:xpath, @@na_input)
  end
end
