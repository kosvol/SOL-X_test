# frozen_string_literal: true

require './././support/env'

class CreatedPermitToWorkPage
  include PageObject

  spans(:ptw_id, xpath: "//li[starts-with(@class,'FormsListItem__Container')]/span[1]")
  spans(:created_by, xpath: "//li[starts-with(@class,'FormsListItem__Container')]/div/div/div/span[1]")
  spans(:created_date_time, xpath: "//li[starts-with(@class,'FormsListItem__Container')]/div/div/div/span[2]")
  buttons(:edit_permit_btn, xpath: "//button[@data-testid='action-button']")
end
