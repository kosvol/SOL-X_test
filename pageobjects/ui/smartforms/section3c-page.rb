# frozen_string_literal: true

require './././support/env'

class Section3CPage < Section3BPage
  include PageObject

  button(:dra_team_btn, id: 'dra_team')
  elements(:dra_team_name, xpath: "//*[starts-with(@class,'ComboButtonMultiselect__Answer-')]")
  buttons(:member_name_btn, xpath: '//ul/li/button')
  buttons(:cancel_and_confirm_btn, xpath: "//button[starts-with(@class,'Button__ButtonStyled-')]")

  def select_dra_team_member
    dra_team_btn
    sleep 1
    member_name_btn_elements.first.click
    cancel_and_confirm_btn_elements.last.click
    sleep 1
  end
end
