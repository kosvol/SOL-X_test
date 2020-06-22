# frozen_string_literal: true

require './././support/env'

class SmartFormsPermissionPage
  include PageObject

  element(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  element(:ptw_id, xpath: "//main[starts-with(@class,'CreateForm__PageContainer')]/div/h2")
  button(:click_permit_type_ddl, xpath: "//button[@id='permitType']")
  button(:back_btn, xpath: "//div[@class='action']/button[starts-with(@class,'Button__ButtonStyled')]")
  button(:save_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/button[starts-with(@class,'Button__ButtonStyled')]")
  buttons(:list_permit_type, xpath: '//ul/li/button')
  text_field(:permit_type, xpath: '//*[@id="section1_permitType"]')
  text_field(:form_number, xpath: '//*[@id="formNumber"]')
  text_field(:vessel_short_name, xpath: '//*[@id="vesselShortName"]')

  def click_create_permit_btn
    click_create_permit_btn_element.click
  end

  permit_type = ''
  def select_random_permit
    click_permit_type_ddl
    sleep 1
    permit_type = get_random_permit
    permit_type.click
    sleep 1
    unless list_permit_type_elements.empty?
      permit_type = get_random_permit
      permit_type.click
    end
    sleep 1
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
    @@permit = _permit
    sleep 1
    list_permit_type_elements.each do |permit|
      permit.click if permit.text === @@permit
    end
  end

  private

  def get_random_permit
    permit = list_permit_type_elements.sample
    permit.text === 'Rigging of Pilot/Combination Ladder' ? get_random_permit : permit
  end

  def get_app_permits
    app_permits = []
    list_permit_type_elements.each do |permit|
      app_permits << permit.text
    end
    app_permits
  end
end
