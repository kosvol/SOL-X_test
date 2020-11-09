# frozen_string_literal: true

require './././support/env'

class Section3CPage < Section3BPage
  include PageObject

  button(:dra_team_btn, id: 'team')
  spans(:dra_team_name_list, xpath: "//button[@id='team']/span")
  element(:master, xpath: "//li[starts-with(@aria-label,'MAS Daniel Alcantara')]")
  element(:am, xpath: "//li[starts-with(@aria-label,'A/M Atif Hayat')]")
  buttons(:member_name_btn, xpath: '//ul/li/button')

  def select_dra_team_member
    sleep 1
    dra_team_btn
    sleep 1
    member_name_btn_elements.first.click
    confirm_btn_elements.last.click
    sleep 1
  end

  def add_additional_dra_member
    dra_team_btn
    member_name_btn_elements.first.click
    confirm_btn_elements.first.click
  end
end
