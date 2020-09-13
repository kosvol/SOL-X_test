require './././support/env'

class PumpRoomEntry
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")

  elements(:all_labels, xpath: '//label')
  element(:all_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]")
  elements(:radio_button_list, xpath: "//span[@class = 'content']/..")

  button(:create_new_pre, xpath: "//span[contains(text(),'Create New Pump Room Entry Permit')]//..")
  button(:add_gas_record, xpath: "//button[contains(.,'Add Gas Test Record')]")

  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  element(:alert_text_1, xpath: "//div[contains(.,'Any discrepancy or abnormalities noted shall be reported to the PIC immediately.')]")
  element(:alert_text_2, xpath: "//div[contains(.,'Please select the start time and duration before submitting.')]")

  def click_create_pump_room_entry
    create_new_pre
  end

  def is_question?(_table)

    _table.all? do |question|
      xpath_str = "//span[contains(text(), '%s')]" % [question[0]]
      p question
      @browser.find_element('xpath', xpath_str).displayed?
    end
  end

end
