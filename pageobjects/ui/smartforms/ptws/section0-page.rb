# frozen_string_literal: true

require './././support/env'

class Section0Page < CommonFormsPage
  include PageObject

  element(:click_create_permit_btn, xpath: "//a[starts-with(@class,'Forms__CreateLink')]")
  elements(:created_ptw_id, xpath: '//li[1]/span')
  element(:ptw_id, xpath: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/h3")
  button(:click_permit_type_ddl, xpath: "//div[starts-with(@class,'ComboButton__')]/button")
  buttons(:list_permit_type, xpath: '//ul/li/button')
  elements(:permit_filter, xpath: "//div[@role='list']/a")
  buttons(:master_approval, xpath: "//button[@data-testid='action-button']")
  element(:select_permit_type, xpath: "//h3[contains(.,'Select Permit Type')]")

  def is_level_1_permit?
    list_permit_type_elements.each do |_element|
    end
  end

  def reset_data_collector
    @@section1_data_collector = [] # reset
  end

  def get_selected_level2_permit
    @@selected_level2_permit
  end

  def select_level2_permit_and_next(_permit)
    select_level2_permit(_permit)
    BrowserActions.poll_exists_and_click(save_and_next_btn_element)
    set_selected_level2_permit(_permit)
    set_current_time
    sleep 1
  end

  def select_level1_permit(_permit)
    CommonPage.set_permit_id(_permit)  ### this might be redundant already
    sleep 1
    select_permit
  end

  private
  def set_selected_level2_permit(_permit)
    @@selected_level2_permit = _permit
  end

  def select_permit
    BrowserActions.wait_until_is_visible(list_permit_type_elements.first)
    list_permit_type_elements.each do |permit|
      next unless permit.text === CommonPage.get_permit_id
      permit.click
      break
    end
  end

  def select_level2_permit(_permit)
    sleep 1
    CommonPage.set_permit_id(_permit)
    unless ['Enclosed Space Entry', 'Helicopter Operation', 'Personnel Transfer by Transfer Basket', 'Rigging of Gangway & Pilot Ladder', 'Use of Non-Intrinsically Safe Camera', 'Use of ODME in Manual Mode', 'Work on Electrical Equipment and Circuits – Low/High Voltage', 'Work on Pressure Pipeline/Vessels', 'Working Aloft / Overside', 'Working on Deck During Heavy Weather'].include? _permit
      select_permit
    end
    @@section1_data_collector << CommonPage.get_permit_id
    @@section1_data_collector << ptw_id_element.text
    CommonPage.set_permit_id(ptw_id_element.text)
  end
end