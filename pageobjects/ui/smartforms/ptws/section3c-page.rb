# frozen_string_literal: true

require './././support/env'

class Section3CPage < Section3BPage
  include PageObject

  button(:dra_team_btn, xpath: "//button[@id='team']")
  spans(:dra_team_name_list, xpath: '//div[starts-with(@class,"Section__Description")]/div/div/div/ul/li')
  element(:master, xpath: "//li[starts-with(.,'MAS COT MAS')]")
  element(:am, xpath: "//li[starts-with(.,'C/O COT C/O')]")
  buttons(:member_name_btn, xpath: '//button[starts-with(@class,"Menu__MenuOption")]')
  buttons(:cross_btn, xpath: '//ul[starts-with(@aria-label,"Selected values")]/li/div[starts-with(@class,"ValueTree__ValueTreeNodeWrapper")]/button') # '//div[starts-with(@class,"Section__Description")]/div/div/div/ul/li/button')

  def select_dra_team_member(_index)
    dra_team_btn
    member_name_btn_elements[_index].click
    confirm_btn_elements.first.click
  end
end
