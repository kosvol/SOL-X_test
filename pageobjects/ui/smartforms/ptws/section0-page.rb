# frozen_string_literal: true

require './././support/env'

class Section0Page < NavigationPage
  include PageObject

  element(:click_create_permit_btn, xpath: "//button[contains(.,'Create Permit To Work')]")
  element(:uat_create_permit_btn, xpath: "//button[contains(.,'Create New Permit to Work')]")
  elements(:created_ptw_id, xpath: '//li[1]/span')
  element(:ptw_id, css: 'header > h1')
  element(:uat_ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  button(:click_permit_type_ddl, xpath: "//div[starts-with(@class,'ComboButton__')]/button")
  buttons(:list_permit_type, css: "div[role='dialog'] > div:nth-child(2) > div > ul > li > button")
  elements(:permit_filter, xpath: "//div[@role='list']/a")
  buttons(:master_approval, xpath: "//button[@data-testid='action-button']")
  element(:select_permit_type, xpath: "//h3[contains(.,'Select Permit Type')]")
  element(:wifi_blob, xpath: "//nav[contains(@class,'NavigationBar__NavBar')]/div/div[1]")
  button(:save_next, css: "button[type='submit']")
  
  def is_level_1_permit?
    list_permit_type_elements.each do |_element|
    end
  end

  def reset_data_collector
    @@section1_data_collector = []
  end

  def get_selected_level2_permit
    @selected_level2_permit
  end

  def select_level2_permit_and_next(permit)
    select_level2_permit(permit)
    save_next
    set_selected_level2_permit(permit)
    set_current_time
    sleep 1
  end

  def select_level1_permit(permit)
    sleep 1
    CommonPage.set_permit_id(permit)
    select_permit
  end

  private
  def set_selected_level2_permit(permit)
    @selected_level2_permit = permit
  end

  def select_permit
    sleep 1
    list_permit_type_elements.each_with_index do |permit,index|
      next unless permit.text === CommonPage.get_permit_id
      permit.click
      break
    end
  end

  def select_level2_permit(permit)
    if permit != 'NA'
      select_permit
      CommonPage.set_permit_id(permit)
    end
    @@section1_data_collector << CommonPage.get_permit_id
    ptw_id_tmp = ptw_id_element.text
    @@section1_data_collector << ptw_id_tmp
    CommonPage.set_permit_id(ptw_id_tmp)
  end
end
