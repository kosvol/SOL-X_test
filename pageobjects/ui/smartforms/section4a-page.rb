# frozen_string_literal: true

require './././support/env'

class Section4APage
  include PageObject

  button(:previous_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[1]")
  button(:next_btn, xpath: "//div[starts-with(@class,'FormNavigationFactory__Button')]/button[2]")
  button(:next_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/label[1]")
  elements(:yes_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]")
  @@yes_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[1]/span"
  elements(:no_input, xpath: "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]")
  @@no_input = "//div[starts-with(@class,'Section__Description')]/div/div[2]/label[2]/span"
  spans(:checklist_name, xpath: "//div[starts-with(@class,'Section__Description')]/div/div/span")

  # ##Blue rgba(24, 144, 255, 1)
  # ##White rgba(255, 255, 255, 1)
  def is_checklist_preselected(_checklist)
    element_yes = $browser.find_elements(:xpath, @@yes_input)
    element_no = $browser.find_elements(:xpath, @@no_input)
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === _checklist

      BrowserActions.scroll_down(element_yes[_index])
      return (element_yes[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)') && (element_no[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)')
    end
  end

  def is_hazardous_substance_checklist
    element_yes = $browser.find_elements(:xpath, @@yes_input)
    element_no = $browser.find_elements(:xpath, @@no_input)
    checklist_name_elements.each_with_index do |checklist, _index|
      next unless checklist.text === 'Work on Hazardous Substances'

      BrowserActions.scroll_down(element_yes[_index])
      return (checklist.text === 'Work on Hazardous Substances') && (element_yes[_index].css_value('background-color') === 'rgba(255, 255, 255, 1)') && (element_no[_index].css_value('background-color') === 'rgba(24, 144, 255, 1)')
    end
  end
end
