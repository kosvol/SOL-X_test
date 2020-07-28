# frozen_string_literal: true

require './././support/env'

class PendingWithdrawalPage < CreatedPermitToWorkPage
  include PageObject

  spans(:task_status_text, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[3]/span[2]")

  def get_task_status_text(_index)
    task_status_text_elements[_index].text
  end
end
