# frozen_string_literal: true

require './././support/env'

class SmartFormsPermissionPage < CommonPage
  include PageObject

  element(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  button(:click_permit_type_ddl, xpath: "//button[@id='permitType']")
  button(:back_btn, xpath: "//div[@class='action']/button[starts-with(@class,'Button__ButtonStyled')]")
  button(:save_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/button[starts-with(@class,'Button__ButtonStyled')]")
  buttons(:list_permit_type, xpath: '//ul/li/button')
  element(:main_clock, xpath: "//h3[@data-testid='main-clock']")
  element(:back_arrow, xpath: "//button/*[@data-testid='arrow']")

  # pending approval permit
  elements(:permit_filter, xpath: "//div[@role='list']/a")
  buttons(:master_approval, xpath: "//button[@data-testid='action-button']")

  def set_current_time
    @@time = main_clock_element.text
  end

  def get_current_time_format
    @which_json = 'ship-local-time/base-get-current-time'
    ServiceUtil.post_graph_ql(@which_json, '1111')
    @@time_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    "#{@@time} LT (GMT+#{@@time_offset})"
  end

  def get_current_date_format
    Time.new.strftime('%d/%b/%Y')
  end

  def reset_data_collector
    @@section1_data_collector = [] # reset
  end

  def set_selected_level2_permit(_permit)
    @@selected_level2_permit = _permit
  end

  def get_selected_level2_permit
    @@selected_level2_permit
  end

  def click_create_permit_btn
    click_create_permit_btn_element.click
  end

  # def get_section1_filled_data
  #   @@section1_data_collector
  # end

  # def set_section1_filled_data
  #   # probably need to dynamic this created by
  #   @@section1_data_collector << 'Created By A/M Atif Hayat at'
  #   sleep 1
  #   @@section1_data_collector << "#{get_current_date_format} #{get_current_time_format}"
  #   p ">>> #{@@section1_data_collector}"
  #   @@section1_data_collector
  # end

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
    sleep 2
    list_permit_type_elements.each do |permit|
      next unless permit.text === @@permit

      permit.click
      break
    end
    @@section1_data_collector << @@permit
    @@section1_data_collector << ptw_id_element.text
    CommonPage.set_permit_id(ptw_id_element.text)
  end

  def get_random_pesrmit
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
