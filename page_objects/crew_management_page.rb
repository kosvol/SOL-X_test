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
    crew_rank: "//tbody/tr/td[@data-testid[contains(., 'rank')]][contains(., '%s')]",
    crew_sname: "//td[contains(., '%s')]/following-sibling::*[@data-testid[contains(., 'lastName')]]",
    crew_fname: "//td[contains(., '%s')]/following-sibling::*[@data-testid[contains(., 'firstName')]]",
    crew_loc: "//td[contains(., '%s')]/following-sibling::*[@data-testid[contains(., 'location')]]//p[1]",
    crew_seen: "//td[contains(., '%s')]/following-sibling::*[@data-testid[contains(., 'location')]]//p/strong",
    crew_loc_time: "//td[contains(., '%s')]/following-sibling::*[@data-testid[contains(., 'location')]]//p[1]/span",
    crew_pin: "//td[contains(., '%s')]/following-sibling::*[@data-testid[contains(., 'pin')]]",
    crew_circle: "//td[contains(., '%s')]//..//div[@class [contains(., 'Indicator')]]",
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
    puts retrieve_rand_pin
    if option == 'not shown'
      compare_string('••••', retrieve_rand_pin)
    elsif option == 'shown' && retrieve_rand_pin == '••••'
      raise 'The PIN is not shown'
    end
  end

  def compare_ui_api_data(rank)
    api_data = retrieve_crew_data_api(rank).to_s
    ui_data = retrieve_crew_data_ui(rank).to_s
    raise "The crew member data don not match UI << #{ui_data} >> vs API << #{api_data} >>" if api_data != ui_data
  end

  def verify_indicator(rank, color)
    indicator_path = format(CREW_MANAGEMENT[:crew_circle], rank)
    indicator = find_element(indicator_path)
    case color
    when 'green'
      compare_string('rgba(67, 160, 71, 1)', indicator.css_value('background-color'))
    when 'yellow'
      compare_string('rgba(242, 204, 84, 1)', indicator.css_value('background-color'))
    else
      raise "undefined #{color}"
    end
  end

  def verify_interval(rank, time)
    case time
    when 'Just Now'
      compare_string(' - Just now', retrieve_time_ago(rank))
    when 'secs ago'
      compare_string(' - secs ago', retrieve_time_ago(rank))
    when 'min ago'
      compare_string(' -  min ago', retrieve_time_ago(rank).tr('0-9', ''))
    when 'mins ago'
      compare_string('Last Seen: ', retrieve_last_seen(rank))
      compare_string(' -  mins ago', retrieve_time_ago(rank).tr('0-9', ''))
    else
      raise "Undefined parameter #{time}"
    end
  end

  private

  def retrieve_rand_pin
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
    result = []
    name = UserService.new.retrieve_rank_and_name(rank)
    pin = UserService.new.retrieve_pin_by_rank(rank)
    location = WearableService.new.crew_assist_retrieve_location(rank)
    result.append(name, location, pin)
    result.join(' ')
  end

  def retrieve_crew_data_ui(rank)
    result = []
    wait_crew_table
    result.append(rank, retrieve_firstname(rank), retrieve_surname(rank), retrieve_location(rank), retrieve_pin(rank))
    result.join(' ')
  end

  def retrieve_surname(rank)
    surname_path = format(CREW_MANAGEMENT[:crew_sname], rank)
    retrieve_text(surname_path)
  end

  def retrieve_firstname(rank)
    firstname_path = format(CREW_MANAGEMENT[:crew_fname], rank)
    retrieve_text(firstname_path)
  end

  def retrieve_location(rank)
    loc_path = format(CREW_MANAGEMENT[:crew_loc], rank)
    location = retrieve_text(loc_path)
    location = location.gsub(retrieve_last_seen(rank), ' ')
    location = location.gsub(retrieve_time_ago(rank), ' ')
    location.lstrip
  end

  def retrieve_last_seen(rank)
    seen_path = format(CREW_MANAGEMENT[:crew_seen], rank)
    retrieve_text(seen_path)
  end

  def retrieve_time_ago(rank)
    time_path = format(CREW_MANAGEMENT[:crew_loc_time], rank)
    retrieve_text(time_path)
  end

  def retrieve_pin(rank)
    pin_path = format(CREW_MANAGEMENT[:crew_pin], rank)
    retrieve_text(pin_path)
  end
end
