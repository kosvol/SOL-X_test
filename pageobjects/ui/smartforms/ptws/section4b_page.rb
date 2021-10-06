# frozen_string_literal: true

require './././support/env'

class Section4BPage < Section4APage
  include PageObject

  element(:loto_rdo, xpath: "//input[starts-with(@name,'eicPreWork_LOTO')]")
  element(:electrical_rdo, xpath: "//input[starts-with(@name,'eicPreWork_ElectricalIsolation')]")
  element(:phy_rdo, xpath: "//input[starts-with(@name,'eicPreWork_PhysicalIsolation')]")
  element(:heading_text, xpath: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3")
  elements(:yes_no_btn, xpath: "//input[@name='energyIsolationCertIssued']")
  text_field(:loto, xpath: "//input[@id='eicPreWork_confirmationAndAcceptance_lotoNumber']")
  text_area(:description_of_work, xpath: "//textarea[@id='descOfWork']")

  button(:save_eic, xpath: "//button[contains(.,'Save EIC')]")
  button(:view_eic_btn, xpath: "//button[contains(.,'View/Edit Energy Isolation Certificate')]")
  button(:create_eic_btn, xpath: "//button[contains(.,'Create Energy Isolation Certificate')]")
  button(:date_and_time_btn, xpath: '//button[@id="workSiteVisitSafetyChecksAndProcsCompletedOn"]')
  elements(:time_picker, xpath: "//div[@class='picker']")
  button(:calendar_btn, xpath: "//button[starts-with(@class,'Day__DayButton')]")
  elements(:wifi_popup, xpath: "//div[starts-with(@class,'PreemptiveOfflineInfo__')]")
  elements(:competent_label, xpath: "//section[starts-with(@class,'Section__SectionMain')]/div/div/h2")

  # sub form
  elements(:eic_date_and_time, xpath: "//button[@id='eic_eicCreatedDate']")
  elements(:eic_signer_name, xpath: "//div[starts-with(@class,'Section__Description')]/div[2]")

  def sign_eic_or_issuer(_condition)
    if ['competent person', 'non competent person'].include? _condition
      BrowserActions.scroll_click(sign_btn_elements.first)
    elsif ['issuing authority', 'non issuing authority'].include? _condition
      BrowserActions.scroll_click(sign_btn_elements.last)
    end
  end

  def is_eic_details_prepopulated?
    sleep 1
    Log.instance.info(">>> #{generic_data_elements[1].text} vs #{get_current_time_format}")
    Log.instance.info(">>> #{generic_data_elements[1].text} vs #{get_current_date_and_time}")
    ((generic_data_elements[1].text == get_current_date_and_time) &&
      (generic_data_elements[2].text.include? 'EIC/TEMP/'))
  end
end
