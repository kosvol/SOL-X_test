# frozen_string_literal: true

require './././support/env'

class PtwPage
  include PageObject

  element(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  element(:ptw_id, xpath: "//main[starts-with(@class,'CreateForm__PageContainer')]/div/h2")
  button(:click_permit_type_ddl, xpath: "//button[@id='permitType']")
  button(:back_btn, xpath: "//div[@class='action']/button[starts-with(@class,'Button__ButtonStyled')]")
  buttons(:list_permit_type, xpath: '//ul/li/button')

  def click_create_permit_btn
    click_create_permit_btn_element.click
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

  def select_level_1_permit(_permit)
    @@permit = _permit
    sleep 1
    list_permit_type_elements.each do |permit|
      permit.click if permit.text === @@permit
    end
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
