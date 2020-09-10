# frozen_string_literal: true

require './././support/env'

class Section3CPage < Section3BPage
  include PageObject

  button(:dra_team_btn, id: 'team')
  elements(:dra_team_name, xpath: "//*[starts-with(@class,'values-area disabled')]/ul/li")
  # elements(:dra_team_name, xpath: "//*[starts-with(@class,'Input__Answer-')]")
  buttons(:member_name_btn, xpath: '//ul/li/button')
  buttons(:cancel_and_confirm_btn, xpath: "//button[starts-with(@class,'Button__ButtonStyled-')]")

  def select_dra_team_member
    sleep 1
    dra_team_btn
    sleep 1
    member_name_btn_elements.first.click
    cancel_and_confirm_btn_elements.last.click
    sleep 1
  end
end
