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
  element(:permit_alert, css: "div[role='alert']")

  def is_level_1_permit?
    list_permit_type_elements.each do |_element|
    end
  end

  def reset_data_collector
    @@section1_data_collector = []
  end

  def get_section1_filled_data
    @@section1_data_collector
  end

  def select_level2_permit_and_next(permit)
    select_level2_permit(permit)
    save_next
    sleep 1
    CommonPage.set_permit_id(ptw_id_element.text)
    set_current_time
  end

  def select_level1_permit(selected_permit)
    sleep 1
    select_permit(selected_permit)
  end

  private

  def select_permit(selected_permit)
    sleep 1
    list_permit_type_elements.each_with_index do |permit, _index|
      next unless permit.text == selected_permit

      permit.click
      @@section1_data_collector << selected_permit
      break
    end
  end

  def select_level2_permit(selected_permit)
    select_permit(selected_permit) if selected_permit != 'NA'
  end
end
