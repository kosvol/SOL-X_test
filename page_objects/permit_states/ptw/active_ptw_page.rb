# frozen_string_literal: true

require_relative '../base_permit_states_page'
require_relative '../../../service/utils/time_service'
require 'time'

# ActivePTWPage object
class ActivePTWPage < BasePermitStatesPage
  attr_accessor :submitted_time, :issued_time, :index

  include EnvUtils
  ACTIVE_PTW = {
    page_header: "//h1[contains(.,'Active Permits to Work')]",
    view_terminate_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View / Terminate')]",
    submitted_time: "(//*[span='%s']/div/*[@class='note-row']/div/span)[2]",
    issued_time: "(//*[span='%s']/div/*[@class='note-row']/div/span)[4]",
    time_left: "(//*[span='%s']/div/*[@class='note-row']/div/span)[6]",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    ptw_id: "//ul[starts-with(@class,'FormsList__Container')]/li/span",
    new_entrant_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'New Entrant')]",
    gas_test_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'Gas Test')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ACTIVE_PTW[:page_header])
  end

  def click_view_terminate_btn(permit_id)
    permit_xpath = ACTIVE_PTW[:view_terminate_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def save_time_info(permit_id)
    wait_for_permit_display(ACTIVE_PTW[:view_terminate_btn] % permit_id)
    self.submitted_time = retrieve_text(ACTIVE_PTW[:submitted_time] % permit_id)
    self.issued_time = retrieve_text(ACTIVE_PTW[:issued_time] % permit_id)
    @logger.info("active page saved submitted time: #{submitted_time}")
    @logger.info("active page saved issued time: #{issued_time}")
  end

  def click_new_entrant_btn(permit_id)
    permit_xpath = ACTIVE_PTW[:new_entrant_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def click_gas_test_btn(permit_id)
    permit_xpath = ACTIVE_PTW[:gas_test_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    click(permit_xpath)
  end

  def verify_issued_date(permit_id)
    permit_xpath = ACTIVE_PTW[:gas_test_btn] % permit_id
    wait_for_permit_display(permit_xpath)
    current_date = TimeService.new.retrieve_current_date
    retrieve_text(permit_xpath).include? current_date
  end

  def verify_time_left(permit_id, expected_time_left)
    permit_xpath = ACTIVE_PTW[:time_left] % permit_id
    wait_for_permit_display(permit_xpath)
    time_left = Time.parse retrieve_text(permit_xpath)
    raise 'time left verification failed' unless time_left.hour == expected_time_left.to_i - 1
  end
end
