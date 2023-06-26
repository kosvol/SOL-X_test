# frozen_string_literal: true

require_relative 'base_page'

# AddCrewWindow object
class AddCrewWindow < BasePage
  include EnvUtils

  ADD_CREW = {
    add_crew_header: "//h2[contains(., 'Add Crew')]",
    description: "//div[@class[contains(., 'Description')]]",
    retrieve_data_btn: "//button[span='Retrieve My Data']",
    add_crew_input: "//div[label[contains(., 'Crew ID')]]/div/input",
    id_header: "//div[label[contains(., 'Enter Your Crew ID')]]",
    placeholder: "//div[input[@placeholder='Required']]",
    error_msg: "//div[@aria-label[contains(., 'error message')]]",
    custom_msg: "//div[label[contains(., 'Crew ID')]]/div[contains(., '%s')]",
    rank_btn: "//button[@class[contains(.,'SelectButton')]]",
    rank: "//ul[starts-with(@class,'UnorderedList-')]/li/button/div",
    view_crew_pin: "//button[contains(., 'View Pin')]",
    crew_pin: "//div[@class[contains(., 'pin-code')]]",
    done_btn: "//button[contains(., 'Done')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ADD_CREW[:add_crew_header])
    @vessel_type = ENV['VESSEL'].upcase
    sleep 1
  end

  def verify_elements
    find_element(ADD_CREW[:id_header])
    find_element(ADD_CREW[:placeholder])
    description = retrieve_text(ADD_CREW[:description])
    message = "Enter your Crew ID to use Safevue on #{@vessel_type}AUTO Vessel"
    compare_string(message.capitalize, description.capitalize)
    verify_button_disable
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

  def verify_rank_ddlist(rank, group)
    click(ADD_CREW[:rank_btn])
    actual_rank = retrieve_elements_text_list(ADD_CREW[:rank])
    expected_rank = expected_rank_list(rank, group)
    raise 'The crew drop down list do not match' if actual_rank != expected_rank
  end

  def expected_rank_list(rank, group)
    list = []
    rank_list = YAML.load_file('data/crew-management/rank_list.yml')
    index = rank_list.index(rank)
    case group
    when 'group_1'
      list.append(rank_list[index - 1], rank, rank_list[index + 1])
    when 'group_2'
      list.append(rank_list[index - 1], rank)
    when 'group_3'
      list.append(rank, rank_list[index + 1])
    when 'group_4'
      list.append(rank)
    else
      raise "Unknown type of group #{group}"
    end
  end

  def view_crew_pin
    click(ADD_CREW[:view_crew_pin])
  end

  def save_pin
    wait_until_enabled(ADD_CREW[:done_btn])
    retrieve_text(ADD_CREW[:crew_pin])
  end

  def verify_new_pin
    raise 'The PIN not shown' if save_pin.is_a?(Integer)

    click(ADD_CREW[:done_btn])
  end

  private

  def verify_button_disable
    verify_btn_availability(ADD_CREW[:retrieve_data_btn], 'disabled')
  end

  def wait_and_check_element(time, element)
    wait = Selenium::WebDriver::Wait.new(timeout: time)
    wait.until { @driver.find_element(:xpath, element).displayed? }
  rescue StandardError
    raise "Time out waiting for #{element}"
  end
end
