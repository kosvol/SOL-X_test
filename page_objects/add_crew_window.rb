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
    custom_msg: "//div[label[contains(., 'Crew ID')]]/div[contains(., '%s')]",
    rank_btn: "//button[@class[contains(.,'SelectButton')]]",
    rank: "//ul[starts-with(@class,'UnorderedList-')]/li/button/div"
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

  def add_crew(crew_id)
    enter_text(ADD_CREW[:add_crew_input], @vessel_type + crew_id)
    sleep 1.5
    click(ADD_CREW[:retrieve_data_btn])
  end

  def verify_message(error_msg)
    wait_and_check_element(5, format(ADD_CREW[:custom_msg], 'Unable to add crew'))
    actual_msg = retrieve_text(ADD_CREW[:error_msg])
    compare_string(error_msg, actual_msg)
  end

  def verify_rank_ddlist(rank)
    click(ADD_CREW[:rank_btn])
    actual_rank = retrieve_elements_text_list(ADD_CREW[:rank])
    expected_rank = expected_rank_list(rank)
    raise 'The crew list don not match' if actual_rank != expected_rank
  end

  def expected_rank_list(rank)
    list = []
    rank_list = YAML.load_file('data/crew-management/rank_list.yml')
    index = rank_list.index(rank)
    list.append(rank_list[index - 1], rank_list[index], rank_list[index + 1])
  end

  private

  def wait_and_check_element(time, element)
    wait = Selenium::WebDriver::Wait.new(timeout: time)
    wait.until { @driver.find_element(:xpath, element).displayed? }
  rescue StandardError
    raise "Time out waiting for #{element}"
  end
end
