# frozen_string_literal: true

require './././support/env'
# require_relative 'dashboard/ship-local-time-page'

class SmartFormsPermissionPage < ShipLocalTimePage
  include PageObject

  element(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  element(:select_permit_screen, xpath: "//label[@for='permitType']")
  # element(:ptw_id, xpath: "//main[starts-with(@class,'CreateForm__PageContainer')]/div/h2")
  element(:ptw_id, xpath: "//section[starts-with(@class,'title')]/h3")
  button(:click_permit_type_ddl, xpath: "//button[@id='permitType']")
  button(:back_btn, xpath: "//div[@class='action']/button[starts-with(@class,'Button__ButtonStyled')]")
  button(:save_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/button[starts-with(@class,'Button__ButtonStyled')]")
  buttons(:list_permit_type, xpath: '//ul/li/button')
  text_field(:permit_type, xpath: '//*[@id="section1_permitType"]')
  text_field(:form_number, xpath: '//*[@id="formNumber"]')
  text_field(:vessel_short_name, xpath: '//*[@id="vesselShortName"]')
  # @@section1_data_collector = []
  # @@selected_level2_permit = ''

  def set_selected_level2_permit(_permit)
    @@selected_level2_permit = _permit
  end

  def get_selected_level2_permit
    @@selected_level2_permit
  end

  def click_create_permit_btn
    click_create_permit_btn_element.click
  end

  def get_section1_filled_data
    @@section1_data_collector
  end

  def set_section1_filled_data
    # probably need to dynamic this created by
    @@section1_data_collector << 'Created By A/M Atif Hayat at'
    clock_btn_element.click
    sleep 1
    @@section1_data_collector << "#{Time.new.strftime('%d/%b/%Y')} #{utc_timezone_elements[1].text} LT (GMT+#{/\d+/.match(utc_time_text)})"
    clock_btn_element.click
    p ">>> #{@@section1_data_collector}"
    @@section1_data_collector
  end

  def select_random_level1_permit
    @@section1_data_collector = [] # reset
    click_permit_type_ddl
    sleep 1
    selected_permit_type = get_random_permit
    selected_permit_type.click
  end

  def select_random_level2_permit
    sleep 1
    unless list_permit_type_elements.empty?
      selected_permit_type = get_random_permit
      selected_permit_type.click
    end
    set_selected_level2_permit(ptw_id_element.text)
    @@section1_data_collector << ptw_id_element.text
    save_btn
  end

  def is_level_1_permit?(_table)
    base_permits = []
    _table.each do |permit|
      base_permits << permit.first
    end
    base_permits === get_app_permits
  end

  def is_level_2_permits?
    base_permits = YAML.load_file('data/permits.yml')[@@permit]
    Log.instance.info("\n\nExpected: #{base_permits}\n\n")
    Log.instance.info("\n\nActual: #{get_app_permits}\n\n")
    base_permits === get_app_permits
  end

  def select_permit(_permit)
    @@section1_data_collector = [] # reset
    @@permit = _permit
    sleep 1
    list_permit_type_elements.each do |permit|
      next unless permit.text === @@permit

      permit.click
      @@section1_data_collector << @@permit
      break
    end
  end

  def get_random_permit
    permit = list_permit_type_elements.sample
    @@section1_data_collector << permit.text
    permit.text === 'Rigging of Pilot/Combination Ladder' ? get_random_permit : permit
  end

  private

  def get_app_permits
    app_permits = []
    list_permit_type_elements.each do |permit|
      app_permits << permit.text
    end
    app_permits
  end
end
