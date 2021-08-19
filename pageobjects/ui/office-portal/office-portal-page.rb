# frozen_string_literal: true

require './././support/env'

class OfficePortalPage
  include PageObject

  button(:op_login_btn, xpath: "//button[contains(@class,'LoginButton')]")
  button(:home_btn, xpath: "//nav[contains(@class,'NavigationBar')]//button")
  button(:all_permits_btn, xpath: "//span[contains(text(),'All Permits')]/parent::button")
  button(:permit_to_work_forms_btn, xpath: "//span[contains(text(),'Permit to Work Forms')]/parent::button")
  button(:other_forms_btn, xpath: "//span[contains(text(),'Other Forms')]/parent::button")
  button(:view_permit_btn, xpath: "//span[contains(text(),'View Selected Permit')]/parent::button")
  button(:add_filter_btn, xpath: "//span[contains(text(),'Add Filter')]/parent::button")
  button(:print_permit_btn, xpath: "//span[contains(text(),'Print')]/parent::button")

  element(:topbar_header, xpath: "//nav[contains(@class,'NavigationBar')]//h1")
  element(:portal_name, xpath: "//h1[contains (@class,'Heading__H1')]")
  element(:warning_message_text, xpath: "//div[contains(text(),'Incorrect Password')]")
  element(:vessels_list_header, xpath: "//h2[contains(text(),'All Vessels')]")
  element(:permit_list, xpath: "//div[contains(@class,'PermitList__Container')]")
  element(:permit_list_cross_btn, xpath: "//div[contains(@class,'PermitList__Header')]//a")
  element(:permits_list_name, xpath: "(//h2[contains(@class,'Heading')])[2]")
  element(:remember_box, xpath: "//span[@class='checkbox']")
  element(:bottom_bar_permits_quantity, xpath: "//span[contains(@class,'BottomBar')]/span")
  element(:permit_approved_on, xpath: "//div[contains(@class,'ApprovedTagWrapper')]")
  element(:first_permit_with_time, xpath: "(//span[contains(text(),'GMT')])[1]/parent::div")
  element(:input_field, xpath: "//h2[starts-with(@class,'Heading__H2-sc')]")
  element(:rol_dd_label, xpath: "//h4[contains(text(),'boarding arrangement:')]")
  element(:s7_issued_from_date, xpath: "//h4[contains(text(),'Issued from')]/following-sibling::p")
  element(:s7_issued_to_date, xpath: "//h4[contains(text(),'Issued till')]/following-sibling::p")
  element(:s7_date_time, xpath: "//h4[contains(text(),'Date/Time:')]/following-sibling::p")
  element(:reporting_header, xpath: "//h1[contains(text(),'Reporting')]")
  element(:permit_archive_tab, xpath: "//a[contains(text(),'Permit Archive')]")
  element(:copy_header_attribute, xpath: "(//span[@class='form-id'][contains(text(),'AUTO')])[1]")
  elements(:permit_check_box, xpath: "//span[@class='checkbox']")
  elements(:vessel_card_name, xpath: "//div[contains(@class,'VesselItem')]/h3")
  elements(:filter_permit_type, xpath: "//div[contains(@class,'PermitType__Container')]//span")
  elements(:permit_section_header, xpath: "//h2[contains(text(),'Section')]")
  elements(:permit_title_number, xpath: "//div[starts-with(@class,'PermitList__List-sc')]/..//span[starts-with(@class,'Text__TextSmall-sc')]")
  elements(:section_headers_all, xpath: "//h2[starts-with(@class,'Heading__H2-sc')]")

  checkbox(:remember_checkbox, xpath: "//input[@type='checkbox']")
  checkboxes(:permit_checkbox, xpath: "//input[@type='checkbox']")
  text_field(:op_password, xpath: "//input[@type='password']")
  elements(:ese_log_table_title_or_value, xpath: "//div[starts-with(@class,'Section__Description')][last()]/..//td[starts-with(@class,'sc-')]")
  def select_vessel(_vesselName)
    $browser.find_element(:xpath, "//h3[contains(text(),'%s')]"%_vesselName).click
  end

  def vessel_card_permits_quantity(_formsQuantity)
    $browser.find_element(:xpath, "//h3[contains(text(), '%s')]/parent::div/following-sibling::div//span[contains(@class,'value')]"%_formsQuantity).text
  end

  def vessel_card_since_date(_sinceDate)
    $browser.find_element(:xpath, "//h3[contains(text(),'%s')]/following-sibling::div//span[contains(text(),'Since')]"%_sinceDate).text
  end

  def vessel_card_last_permit_date(_lastPermitDate)
    $browser.find_element(:xpath, "//h3[contains(text(),'%s')]/following-sibling::div//span[contains(text(),'Last Permit')]"%_lastPermitDate).text
  end

  def select_permit_by_number(_whatNumber)
    $browser.find_element(:xpath, "//span[contains(text(),'%s')]/..//span[contains(@class,'check')]"%_whatNumber).click
  end

  def get_permit_number(_permitNumber)
    $browser.find_element(:xpath, "//div[%s][contains(@class,'PermitItem')]/span[1]"%_permitNumber).text
  end

  def get_permit_name(_permitName)
    $browser.find_element(:xpath, "//div[%s][contains(@class,'PermitItem')]/span[2]"%_permitName).text
  end

  def get_approved_date_time
    $browser.find_element(:xpath, "//h4[contains(text(),'Date/Time:')]/following-sibling::p").text
  end

  def select_element_by_text_near(_text_title)
    $browser.find_element(:xpath, "//h4[contains(text(),'%s')]/..//p[starts-with(@class,'AnswerComponent__Answer')]"%_text_title)
  end

  def get_section_headers_list(_section)
    subheadersArr = []
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{_section}')])/../..//h2").each do |_subheader|
      subheadersArr << _subheader.text
    end
    subheadersArr -= YAML.load_file("data/screens-label/#{_section}.yml")['subheaders_exceptions']
    return subheadersArr
  end

  def get_section_subheaders_list(_section)
    labelsArr = []
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{_section}')])/../..//label").each do |_label|
      labelsArr << _label.text
    end
    labelsArr -= YAML.load_file("data/screens-label/#{_section}.yml")['labels_exceptions']
    return labelsArr
  end

  def get_section_fields_list(_section)
    fieldsArr = []
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{_section}')])/../..//h4").each do |_field|
      fieldsArr << _field.text
    end
    fieldsArr -= YAML.load_file("data/screens-label/#{_section}.yml")['fields_exceptions']
    return fieldsArr
  end

  def oa_date_time_with_offset(_approve_time, _time_offset)
    if _time_offset.to_s[0] != "-"
      date_time = (_approve_time + (60*60*_time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT+#{_time_offset})")
    else
      date_time = (_approve_time + (60*60*_time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT#{_time_offset})")
    end
    p "#{date_time}"
    return date_time
  end
end