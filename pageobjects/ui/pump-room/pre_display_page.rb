# frozen_string_literal: true

require './././features/support/env'

class PreDisplay < Section9Page
  include PageObject
  # include GasReading

  element(:warning_box, xpath: "//div[starts-with(@aria-label,'create-entry-record')]/div/div")
  element(:permit_status, xpath: "//*[contains(text(),'Permit')]")
  elements(:info_gas_testing_is_missing, xpath: "//div[starts-with(@class,'GasTesting')]/*")
  elements(:pre_structure_on_pred,
           xpath: "//div/*[local-name()='h3' or (local-name()='span'  and not(contains(text(),'LT')))]")
  @@button_li = "//span[contains(text(),'%s')]/ancestor::li" # home, entry log, permit

  element(:entrant_count, xpath: "//span[starts-with(@aria-label,'active-entrant-counter')]")
  element(:new_entry_log, xpath: "//span[contains(text(),'New Entry')]")
  element(:send_report, xpath: "//span[contains(text(),'Send Report')]")
  element(:entry_log_btn, xpath: "//a[contains(.,'Entry Log')]")
  elements(:sign_out_btn, xpath: "//span[contains(text(),'Sign Out')]")
  elements(:cross_btn, xpath: "//button[contains(@class,'Button__ButtonStyled-')]/span")
  elements(:cross_button, xpath: "//button[starts-with(@class,'Button__ButtonStyled')]")
  element(:home_tab, xpath: "//a[contains(.,'Home')]")
  element(:entry_log_tab, xpath: "//a[contains(.,'Entry Log')]")
  element(:permit_tab, xpath: "//a[contains(.,'Permit')]")
  element(:pre_creator_display, xpath: "//span[contains(@class,'ActivePermitDetails')]")
  element(:time_shifted_by_text, xpath: "//p[contains(@class,'PermitValidUntil__TextSmall')]")
  element(:pre_duration_timer, xpath: "//h4/strong[contains(@class,'PermitValidUntil__')]") # ""//div[contains(@class,'PermitValidUntil__SecondaryHeaderText')]/span")
  buttons(:send_report_btn, xpath: '//button[contains(.,"Send Report")]')
  element(:no_entry_yet, xpath: "(//h2[contains(text(),'No Entry Yet')])")
  element(:warning_box_alert_wiper, xpath: "//div[starts-with(@class,'WarningBox__AlertWrapper')]")
  element(:entry_disclaimer, xpath: "//div[starts-with(@class,'CreateEntryRecord__EntryDisclaimer')]")

  def is_element_disabled_by_att?(text)
    # enable? - doesn't work for PRED. for 'li' elements
    xpath_str = format(@@button_li, text)
    el = @browser.find_element('xpath', xpath_str)
    !el.attribute('disabled').nil?
  rescue StandardError
    false
  end

  def background_color?
    @browser.find_element(:xpath, "//*[@id='root']/div/main").css_value('background-color')
  end

  def sign_component_text?
    @browser.find_element(:xpath, "(//div[@class='children']/div/div/div/div[3]/div/div)").text
  end

  def ret_required_entrants(count)
    @browser
      .find_element(:xpath,
                    "//*[starts-with(@class,'UnorderedList')]/li[#{count}]")
  end

  def check_entrant_name(name)
    @browser.find_elements(:xpath, "//*[contains(.,'#{name}')]").empty?
  end
end
