# frozen_string_literal: true

require_relative '../../base_page'

# PermitDetailPage object
class PermitDetailPage < BasePage
  include EnvUtils
  PERMIT_DETAIL = {
    page_header: "//h1[contains(.,'Permit Details')] ",
    permit_no: "(//p[starts-with(@class, 'AnswerComponent__Answer')])[4]"
  }.freeze

  def initialize(driver)
    super
    @retry_count = 0
  end

  def wait_for_permit_active(permit_id)
    @driver.get("#{retrieve_env_url}/entry-display/permit-details")
    compare_string(permit_id, retrieve_text(PERMIT_DETAIL[:permit_no]))
  rescue StandardError
    @retry_count += 1
    @logger.debug("wait permit active #{permit_id}, retrying #{@retry_count} times")
    sleep 2
    @driver.navigate.refresh
    wait_for_permit_active(permit_id)
    raise 'time out waiting for permit display' if @retry_count > 20
  end
end
