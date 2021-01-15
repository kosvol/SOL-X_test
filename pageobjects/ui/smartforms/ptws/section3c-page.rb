# frozen_string_literal: true

require './././support/env'

class Section3CPage < Section3BPage
  include PageObject

  button(:dra_team_btn, id: 'team')
  spans(:dra_team_name_list, xpath: '//div[starts-with(@class,"Section__Description")]/div/div/div/ul/li')
    #"//button[@id='team']/span")
  element(:master, xpath: "//li[starts-with(@aria-label,'MAS Daniel Alcantara')]")
  element(:am, xpath: "//li[starts-with(@aria-label,'A/M Atif Hayat')]")
  buttons(:member_name_btn, xpath: '//div[starts-with(@class,"items")]/ul/li/button')
  buttons(:cross_btn, xpath: '//div[starts-with(@class,"Section__Description")]/div/div/div/ul/li/button')
  

  def select_dra_team_member(_index)
    dra_team_btn
    member_name_btn_elements[_index].click
    confirm_btn_elements.first.click
  end
end
