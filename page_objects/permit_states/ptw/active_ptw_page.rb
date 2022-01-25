# frozen_string_literal: true

require_relative 'base_permit_states_page'

# ActivePTWPage object
class ActivePTWPage < BasePermitStatesPage
  attr_accessor :submitted_time, :issued_time, :index

  include EnvUtils
  ACTIVE_PTW = {
    page_header: "//h1[contains(.,'Active Permits to Work')]",
    view_terminate_btn: "//*[span='%s']/*[@class='note-row']/button[contains(.,'View / Terminate')]",
    submitted_time: "(//*[span='%s']/div/*[@class='note-row']/div/span)[2]",
    issued_time: "(//*[span='%s']/div/*[@class='note-row']/div/span)[4]",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    ptw_id: "//ul[starts-with(@class,'FormsList__Container')]/li/span",
    new_entrant_btn: "//button[contains(.,'New Entrant')]"
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
    get_permit_index(permit_id)
    find_elements(ACTIVE_PTW[:new_entrant_btn])[index.to_i].click
  end

  private

  def get_permit_index(permit_id)
    find_elements(ACTIVE_PTW[:parent_container]).each_with_index do |_permit, index|
      next unless find_elements(ACTIVE_PTW[:ptw_id])[index].text == permit_id

      Log.instance.info "Permit ID: #{find_elements(ACTIVE_PTW[:ptw_id])[index].text} ::: #{permit_id}"
      Log.instance.info "Index: #{index}"
      self.index = index
      break
    end
  end
end
