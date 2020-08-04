# frozen_string_literal: true

require './././support/env'

class Section5Page < Section4BPage
  include PageObject

  button(:roles_and_resp_btn, xpath: "//div[starts-with(@class,'values-area')]/button")
  # span(:dra_team_name, xpath: "//button[@id='dra_team']/span")
  button(:sign_btn, xpath: "//div[@data-testid='responsibility-box']/button")
  # buttons(:cancel_and_confirm_btn, xpath: "//button[starts-with(@class,'Button__ButtonStyled-')]")

  def select_roles_and_responsibility
    roles_and_resp_btn
    sleep 1
    member_name_btn_elements.first.click
    cancel_and_confirm_btn_elements.last.click
    sleep 1
  end
end
