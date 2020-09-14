require './././support/env'

class PumpRoomEntry
  include PageObject

  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")

  elements(:all_labels, xpath: '//label')
  element(:all_sections, xpath: "//section[starts-with(@class,'Section__SectionMain')]")
  elements(:radio_button_list, xpath: "//span[@class = 'content']/..")

  button(:create_new_pre, xpath: "//span[contains(text(),'Create New Pump Room Entry Permit')]//..")
  button(:add_gas_record, xpath: "//button[contains(.,'Add Gas Test Record')]")
  button(:permit_validation, xpath: "//button[@id='permitValidDuration']")

  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")

  @@alert_text =  "//div[contains(.,'%s')]"
  @@alert_text_2 = "//div[contains(.,'Please select the start time and duration before submitting.')]"
  @@permit_duration = "//button[contains(text(),'%s')]"
  @@button = "//span[contains(text(),'%s')]//.."

  def click_create_pump_room_entry
    create_new_pre
  end



  def is_questions?(table)
    table.all? do |question|
      xpath_str = "//span[contains(text(), '%s')]" % [question[0]]
      @browser.find_element('xpath', xpath_str).displayed?
    end
  end

  def is_alert_text_visible?(alert_text)
    xpath_str = @@alert_text % [alert_text]
    @browser.find_element("xpath", xpath_str).displayed?
  rescue StandardError
    false
  end

  def select_permit_duration(duration)
    BrowserActions.scroll_down(permit_validation) #scroll+click
    sleep 1
    xpath_str = @@permit_duration%[duration]
    @browser.find_element("xpath", xpath_str).click
  end

  def is_button_enabled?(button_text)
    xpath_str = @@button%[button_text]
    @browser.find_element("xpath", xpath_str).enabled?
  end

  def xpath_fast_check(xpath)
    #x = "//div[@id='PRE_SECTION_1_subsection24']"
    #test_str = %(return document.evaluate("%s", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;)%[x]
  end

end
