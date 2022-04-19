# frozen_string_literal: true

require_relative '../../base_page'
require_relative '../../../service/utils/user_service'
require 'yaml'

# Entry display page object
class EntryDisplay < BasePage
  ENTRY_DISPLAY = {
    page_header: "//*[@id='root']/div/nav/header",
    entry_log_btn: "//a[contains(.,'Entry Log')]",
    entry_log_header: "//h2[starts-with(@class, 'Heading')]",
    entry_log_table: "//div[@data-testid='entry-log-column']/div",
    new_entry_button: "//span[contains(text(),'Log Entrant(s)')]",
    entry_log_tab: "//a[contains(.,'Entry Log')]",
    permit_tab: "//a[contains(.,'Permit')]",
    home_tab: "//a[contains(.,'Home')]",
    entrant_count: "//span[starts-with(@aria-label,'active-entrant-counter')]",
    header_cell: "//div[starts-with(@class,'header-cell')]",
    duration_timer: "//div[starts-with(@class, 'PermitValidUntil')]",
    main_page: "//*[@id='root']/div/main",
    creator: "//h3[starts-with(@class, 'Heading__H3')]/span",
    sign_out_btn: "//span[contains(text(),'Sign Out')]",
    first_cross_btn: "(//button[starts-with(@class, 'Button__ButtonStyled')])[2]",
    sign_out_pop_out: "(//button[starts-with(@class, 'Button__ButtonStyled')])[3]"
  }.freeze

  COLOR_MAP = {
    red: 'rgba(216, 75, 75, 1)',
    green: 'rgba(67, 160, 71, 1)'
  }.freeze

  TIMER = %w[03:59: 03:58: 03:57: 03:56:].freeze

  def initialize(driver)
    super
    find_element(ENTRY_DISPLAY[:page_header])
  end

  def wait_for_background_update(type, color)
    attempt = 0
    until retrieve_background_color == COLOR_MAP[color.to_sym]
      sleep 2
      attempt += 1
      raise "timeout for waiting #{type} permit" if attempt == 40
    end
  end

  def verify_entry_log(new_entry)
    sleep 2 # wait for the flash
    scroll_click(ENTRY_DISPLAY[:entry_log_btn])
    sleep 1 # wait for the flash
    if new_entry == 'yes'
      find_elements(ENTRY_DISPLAY[:entry_log_table])
    else
      compare_string('No Entry Yet', retrieve_text(ENTRY_DISPLAY[:entry_log_header]))
    end
  end

  def click_new_entry_btn
    click(ENTRY_DISPLAY[:new_entry_button])
  end

  def click_entry_tab(tab)
    case tab
    when 'home'
      click(ENTRY_DISPLAY[:home_tab])
    when 'entry log'
      click(ENTRY_DISPLAY[:entry_log_tab])
    when 'permit'
      click(ENTRY_DISPLAY[:permit_tab])
    else
      raise "Wrong condition >>> #{tab}"
    end
  end

  def check_entrant_count(count)
    if count == '0'
      verify_element_not_exist(ENTRY_DISPLAY[:entrant_count])
    else
      compare_string(count, retrieve_text(ENTRY_DISPLAY[:entrant_count]))
    end
  end

  def verify_entry_log_table
    expected_headers = YAML.load_file('data/entry/entry_log_table.yml')['headers']
    page_table_headers = find_elements(ENTRY_DISPLAY[:header_cell])
    page_table_headers.each_with_index do |element, index|
      compare_string(expected_headers[index], element.text)
    end
  end

  def verify_validity_time
    actual_timer = retrieve_text(ENTRY_DISPLAY[:duration_timer])
    raise 'Wrong timer countdown' unless TIMER.any? { |element| actual_timer.include? element }
  end

  def verify_creator(creator_rank)
    expected_rank_name = UserService.new.retrieve_rank_and_name(creator_rank)
    compare_string(expected_rank_name, retrieve_text(ENTRY_DISPLAY[:creator]))
  end

  def sign_out_first_entrant
    click(ENTRY_DISPLAY[:sign_out_btn])
    click(ENTRY_DISPLAY[:first_cross_btn])
    sleep 0.5
    click(ENTRY_DISPLAY[:sign_out_pop_out])
  end

  private

  def retrieve_background_color
    find_element(ENTRY_DISPLAY[:main_page]).css_value('background-color')
  end
end
