# frozen_string_literal: true

require_relative 'base_page'

# AddCrewWindow object
class AddCrewWindow < BasePage
  include EnvUtils

  ADD_CREW = {
    add_crew_header: "//h2[contains(., 'Add Crew')]",
    retrieve_data_btn: "//button/span[contains(., 'Retrieve My Data')]",
    add_crew_input: "//div[label[contains(., 'Crew ID')]]/div/input",
    error_msg: "//div[@aria-label[contains(., 'error message')]]",
    custom_msg: "//div[label[contains(., 'Crew ID')]]/div[contains(., '%s')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ADD_CREW[:add_crew_header])
    @vessel_type = ENV['VESSEL'].upcase
    sleep 1
  end

  def verify_button(text, option)
    verify_btn_availability("//button[span=\"#{text}\"]", option)
  end

  def add_crew(id)
    enter_text(ADD_CREW[:add_crew_input], @vessel_type + id)
    sleep 1.5
    click(ADD_CREW[:retrieve_data_btn])
  end

  def verify_message(error_msg)
    wait_and_check_element(5, format(ADD_CREW[:custom_msg], 'Unable to add crew'))
    actual_msg = retrieve_text(ADD_CREW[:error_msg])
    compare_string(error_msg, actual_msg)
  end

  private

  def wait_and_check_element(time, element)
    wait = Selenium::WebDriver::Wait.new(timeout: time)
    wait.until { @driver.find_element(:xpath, element).displayed? }
  rescue StandardError
    raise "Time out waiting for #{element}"
  end
end