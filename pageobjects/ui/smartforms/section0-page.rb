# frozen_string_literal: true

require './././support/env'

class Section0Page < CommonFormsPage
  include PageObject

  element(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  elements(:created_ptw_id, xpath: '//li[1]/span')
  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  button(:click_permit_type_ddl, xpath: "//button[contains(.,'Select')]")
  # button(:save_btn, xpath: "//div[starts-with(@class,'Section__Description')]/div/button[starts-with(@class,'Button__ButtonStyled')]")
  buttons(:list_permit_type, xpath: '//ul/li/button')
  # pending approval permit
  elements(:permit_filter, xpath: "//div[@role='list']/a")
  buttons(:master_approval, xpath: "//button[@data-testid='action-button']")
  element(:select_permit_type, xpath: "//label[contains(.,'Select Permit Type')]")

  def is_level_1_permit?
    list_permit_type_elements.each do |_element|
    end
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

  def select_level1_permit(_permit)
    CommonPage.set_permit_id(_permit)
    sleep 2
    select_permit
  end

  def select_level2_permit(_permit)
    CommonPage.set_permit_id(_permit)
    sleep 2
    unless ['Enclosed Space Entry', 'Helicopter Operation', 'Personnel Transfer by Transfer Basket', 'Rigging of Gangway & Pilot Ladder', 'Use of Non-Intrinsically Safe Camera', 'Use of ODME in Manual Mode', 'Work on Electrical Equipment and Circuits – Low/High Voltage', 'Work on Pressure Pipeline/Vessels', 'Working Aloft / Overside', 'Working on Deck During Heavy Weather'].include? _permit
      select_permit
    end
    @@section1_data_collector << CommonPage.get_permit_id
    @@section1_data_collector << ptw_id_element.text
    CommonPage.set_permit_id(ptw_id_element.text)
  end

  private

  def select_permit
    list_permit_type_elements.each do |permit|
      next unless permit.text === CommonPage.get_permit_id

      permit.click
      break
    end
  end
end
