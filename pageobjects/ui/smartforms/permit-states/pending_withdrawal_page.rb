# frozen_string_literal: true

require './././features/support/env'

class PendingWithdrawalPage < CreatedPermitToWorkPage
  include PageObject

  spans(:task_status_text, xpath: "//ul[starts-with(@class,'FormsList__Container')]/li/div/div/div[3]/span[2]")
  buttons(:review_n_withdraw, xpath: "//button[contains(.,'Review & Withdraw')]")

  def task_status_text(index)
    task_status_text_elements[index].text
  end
end
