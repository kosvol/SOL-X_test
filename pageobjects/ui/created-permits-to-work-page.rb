# frozen_string_literal: true

require './././support/env'

class CreatedPermitToWorkPage
  include PageObject

  spans(:ptw_id, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/span")
  spans(:created_by, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div/span[1]")
  spans(:created_date_time, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div/span[2]")
  buttons(:edit_permit_btn, xpath: "//button[@data-testid='action-button']")
end
