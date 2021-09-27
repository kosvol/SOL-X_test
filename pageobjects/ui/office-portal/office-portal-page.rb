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
  element(:permit_approved_on, xpath: "(//div[contains(@class,'ApprovedTagWrapper')])[2]")
  element(:first_permit_with_time, xpath: "(//span[contains(text(),'GMT')])[1]/parent::div")
  element(:input_field, xpath: "//h2[starts-with(@class,'Heading__H2-sc')]")
  element(:rol_dd_label, xpath: "//h4[contains(text(),'boarding arrangement:')]")
  element(:s7_issued_from_date,
          xpath: "//div[@class='screen-only']//h4[contains(text(),'Issued from')]/following-sibling::p")
  element(:s7_issued_to_date,
          xpath: "//div[@class='screen-only']//h4[contains(text(),'Issued till')]/following-sibling::p")
  element(:s7_date_time,
          xpath: "//div[@class='screen-only']//h4[contains(text(),'Date/Time:')]/following-sibling::p")
  element(:reporting_header, xpath: "//h1[contains(text(),'Reporting')]")
  element(:permit_archive_tab, xpath: "//a[contains(text(),'Permit Archive')]")
  element(:copy_header_attribute, xpath: "(//span[@class='form-id'][contains(text(),'AUTO')])[1]")
  elements(:permit_check_box, xpath: "//span[@class='checkbox']")
  elements(:vessel_card_name, xpath: "//div[contains(@class,'VesselItem')]/h3")
  elements(:filter_permit_type, xpath: "//div[contains(@class,'PermitType__Container')]//span")
  elements(:permit_section_header, xpath: "//div[@class='screen-only']//h2[contains(text(),'Section')]")
  elements(:permit_title_number,
           xpath: "//div[starts-with(@class,'PermitList__List-sc')]/..//span[starts-with(@class,'Text__TextSmall-sc')]")
  elements(:section_headers_all, xpath: "//h2[starts-with(@class,'Heading__H2-sc')]")
  checkbox(:remember_checkbox, xpath: "//input[@type='checkbox']")
  checkboxes(:permit_checkbox, xpath: "//input[@type='checkbox']")
  text_field(:op_password, xpath: "//input[@type='password']")
  elements(:ese_log_table_title_or_value,
           xpath: "//div[starts-with(@class,'Section__Description')][last()]/..//td[starts-with(@class,'sc-')]")
  def select_vessel(vessel_name)
    $browser.find_element(:xpath, "//h3[contains(text(),'%s')]" % vessel_name).click
  end

  def vessel_card_permits_quantity(forms_quantity)
    $browser
      .find_element(:xpath,
                    "//h3[contains(text(), '#{forms_quantity}')]/parent::div/following-sibling::div//span[contains(@class,'value')]").text
  end

  def vessel_card_since_date(since_date)
    $browser
      .find_element(:xpath,
                    "//h3[contains(text(),'#{since_date}')]/following-sibling::div//span[contains(text(),'Since')]").text
  end

  def vessel_card_last_permit_date(last_permit_date)
    $browser
      .find_element(:xpath,
                    "//h3[contains(text(),'#{last_permit_date}')]/following-sibling::div//span[contains(text(),'Last Permit')]").text
  end

  def select_permit_by_number(what_number)
    $browser.find_element(:xpath,
                          "//span[contains(text(),'#{what_number}')]/..//span[contains(@class,'check')]").click
  end

  def get_permit_number(permit_number)
    $browser.find_element(:xpath, "//div[%s][contains(@class,'PermitItem')]/span[1]" % permit_number).text
  end

  def get_permit_name(permit_name)
    $browser.find_element(:xpath, "//div[%s][contains(@class,'PermitItem')]/span[2]" % permit_name).text
  end

  def get_approved_date_time
    $browser.find_element(:xpath, "(//h4[contains(text(),'Date/Time:')]/following-sibling::p)[2]").text
  end

  def select_element_by_text_near(text_title)
    $browser.find_element(:xpath,
                          "//h4[contains(text(),'#{text_title}')]/..//p[starts-with(@class,'AnswerComponent__Answer')]")
  end

  def get_section_elements_list(section, element_type)
    fields_arr = []
    $browser.find_elements(:xpath, "(//h2[contains(text(),'#{section}')])/../..//#{element_type}").each do |field|
      fields_arr << field.text
    end
    YAML.load_file("data/screens-label/#{section}.yml")['subheaders_exceptions'] if element_type == 'h2'
    YAML.load_file("data/screens-label/#{section}.yml")['labels_exceptions'] if element_type == 'label'
    YAML.load_file("data/screens-label/#{section}.yml")['fields_exceptions'] if element_type == 'h4'
  end

  def oa_date_time_with_offset(approve_time, time_offset)
    date_time = if time_offset.to_s[0] != '-'
                  (approve_time + (60 * 60 * time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT+#{time_offset})")
                else
                  (approve_time + (60 * 60 * time_offset)).strftime("%d/%b/%Y %H:%M LT (GMT#{time_offset})")
                end
    p date_time.to_s
    date_time
  end
end
