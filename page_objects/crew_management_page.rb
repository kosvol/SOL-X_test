# frozen_string_literal: true

require_relative 'base_page'

# CrewManagementPage object
class CrewManagementPage < BasePage
  include EnvUtils

  CREW_MANAGEMENT = {
    header: "//h1[contains(., 'Crew Management')]",
    pin_btn: "//button[contains(., 'View PINs')]",
    wrh_btn: "//button[contains(., 'View Work Rest Hours')]",
    add_crew_btn: "//button[contains(., 'Add New Crew')]",
    rank_clmn: "//th[contains(., 'Rank')]",
    s_name_clmn: "//th[contains(., 'Surname')]",
    f_name_clmn: "//th[contains(., 'First Name')]",
    loc_clmn: "//th[contains(., 'Location')]",
    pin_clmn: "//th[contains(., 'PIN')]",
    work_clmn: "//th[contains(., 'Work Availability')]",
    total_crew: "//strong[contains(., 'Total')]/following::*[1]",
    crew_table: '//tbody/tr',
    # crew_data_ui: "//tbody/tr/td[contains(., '%s')]/following::*[1]",
    crew_rank: "//tbody/tr/td[@data-testid[contains(., 'rank')]][contains(., '%s')]",
    crew_sname: '/following::*[2]',
    crew_fname: '/following::*[4]',
    crew_loc: "/following::*[@class[contains(., 'LocationName')]]",
    crew_pin: '/following::*[8]',
    timer: "//button[@class[contains(., 'view-pin')]]",
    timer_btn: "//button[contains(., 'Hiding')]",
    pin: '//tbody/tr/td[5]'
  }.freeze

  def verify_elements
    find_element(CREW_MANAGEMENT[:header])
    verify_table
    verify_btns
  end

  def compare_crew_count
    wait_crew_table
    raise 'Quantity did not match' if total_crew.to_i != crew_list.to_i
  end

  def compare_crew_qnt_ui_db
    db_quantity = create_rank_list_api.length
    raise 'Quantity did not match with DB' if db_quantity.to_i != crew_list.to_i
  end

  def retrieve_crew_data_ui(rank)
    result = []
    wait_crew_table
    rank_path = (format(CREW_MANAGEMENT[:crew_rank], rank))

    surname = retrieve_text(rank_path + CREW_MANAGEMENT[:crew_sname])
    puts surname
    firstname = retrieve_text(rank_path + (CREW_MANAGEMENT[:crew_fname]))
    puts firstname
    location = retrieve_text2(rank_path + (CREW_MANAGEMENT[:crew_loc]))
    location = location.scan(/\d+/).first.to_i
    location = location.delete("\\Last seen mins ago")
    puts location
    # pin = retrieve_text(rank_path + (CREW_MANAGEMENT[:crew_pin]))
    # result.append(rank, surname, firstname, location, pin)
    puts result
    end
   # puts "Its a >>#{res.attribute("value")}"
   # end
   #  def retrieve_actual_dra_answers
   #     result = []
   #     actual_answers = @driver.find_elements(:xpath, ROL_SECTION_ONE[:form_answers])
   #     actual_answers.each do |element|
   #       result.append(element.text)
   #     end
   #     result

  def click_view_pin
    click(CREW_MANAGEMENT[:pin_btn])
  end

  def verify_timer
    case retrieve_text_timer
    when 'Hiding in 10 secs'
      true
    when 'Hiding in 9 secs'
      true
    when 'Hiding in 8 secs'
      true
    else
      raise "Wrong count down text >>> #{retrieve_text_timer}"
    end
  end

  def verify_pin_availability(option)
    puts retrieve_pin
    if option == 'not shown'
      compare_string('••••', retrieve_pin)
    elsif option == 'shown' && retrieve_pin == '••••'
      raise 'The PIN is not shown'
    end
  end

  def compare_ui_api_data(rank)
    puts(retrieve_crew_data_api(rank))
    puts(retrieve_crew_data_ui(rank))
  end

  private

  def retrieve_pin
    retrieve_text(CREW_MANAGEMENT[:pin])
  end

  def retrieve_text_timer
    find_element(CREW_MANAGEMENT[:timer_btn])
    retrieve_text(CREW_MANAGEMENT[:timer])
  end

  def wait_crew_table
    wait = Selenium::WebDriver::Wait.new(timeout: 15)
    wait.until { @driver.find_element(:xpath, CREW_MANAGEMENT[:crew_table]).displayed? }
  rescue StandardError
    raise 'Time out waiting for Crew Table data'
  end

  def total_crew
    retrieve_text(CREW_MANAGEMENT[:total_crew])
  end

  def crew_list
    find_elements(CREW_MANAGEMENT[:crew_table]).size
  end

  def verify_btns
    find_element(CREW_MANAGEMENT[:pin_btn])
    find_element(CREW_MANAGEMENT[:wrh_btn])
    find_element(CREW_MANAGEMENT[:add_crew_btn])
  end

  def verify_table
    find_element(CREW_MANAGEMENT[:rank_clmn])
    find_element(CREW_MANAGEMENT[:s_name_clmn])
    find_element(CREW_MANAGEMENT[:f_name_clmn])
    find_element(CREW_MANAGEMENT[:loc_clmn])
    find_element(CREW_MANAGEMENT[:pin_clmn])
    find_element(CREW_MANAGEMENT[:work_clmn])
  end

  def create_rank_list_api
    rank_list = []
    user_list_response = UsersApi.new.request
    user_list_response['data']['users'].each do |user|
      rank_list.append(user['crewMember']['rank'])
    end
    rank_list
  end

  def retrieve_crew_data_api(rank)
    user_list_response = UsersApi.new.request
    user_list_response['data']['users'].each do |user|
      user_db_list = user['crewMember']['rank'], user['crewMember']['lastName'], user['crewMember']['firstName'],
                     user['pin']
      return user_db_list if user['crewMember']['rank'] == rank
    end
  end
end
