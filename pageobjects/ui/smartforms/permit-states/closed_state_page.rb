# frozen_string_literal: true

require './././support/env'

class ClosedStatePage < Section9Page
  include PageObject

  elements(:terminated_date_time,
           xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[3]/span[2]")
end
