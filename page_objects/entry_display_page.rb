# frozen_string_literal: true

require_relative 'base_page'

# Entry display page object
class EntryDisplay < BasePage

  ENTRY_DISPLAY = {
    page_header: "//*[@id='root']/div/nav/header",
    entry_log_btn: "//a[contains(.,'Entry Log')]",
    info_gas_testing_is_missing: "//div[starts-with(@class,'GasTesting')]/*",
    entry_log_table: "//div[@data-testid='entry-log-column']/div",
    new_entry_button: "//span[contains(text(),'Log Entrant(s)')]",
    entry_log_tab: "//a[contains(.,'Entry Log')]",
    permit_tab: "//a[contains(.,'Permit')]",
    home_tab: "//a[contains(.,'Home')]",
    entrant_count: "//span[starts-with(@aria-label,'active-entrant-counter')]",
    header_cell: "//div[starts-with(@class,'header-cell')]",
    generic_data: "//*[starts-with(@class,'AnswerComponent__Answer')]",
    duration_timer: "//h4/strong[contains(@class,'PermitValidUntil__')]",
    resp_off_signature: "//h2[contains(.,'Responsible Officer Signature')",
    resp_off_signature_rank: "//h3[contains(.,'Rank/Name')]",
    template_path: "//div[contains(.,'%s')]"
  }.freeze

  BACKGROUND_COLOR = {
    green: 'rgba(216, 75, 75, 1)',
    red: 'rgba(67, 160, 71, 1)'
  }.freeze

  TIMER = %w[03:58: 03:57: 03:56:].freeze

  def initialize(driver)
    super
    find_element(ENTRY_DISPLAY[:page_header])
  end

  def wait_for_permit(type)
    attempt = 0
    until return_background_color == type
      attempt += 1
      raise "timeout for waiting #{type} permit" if attempt == 30
    end
  end

  def check_background_color(condition)
    raise "Wrong background color #{condition}" unless return_background_color.eql?(BACKGROUND_COLOR[condition])
  end

  def check_without_new_entry
    click(ENTRY_DISPLAY[:entry_log_btn])
    no_entry_element = find_elements(ENTRY_DISPLAY[:info_gas_testing_is_missing])[2]
    new_entry_message = find_elements(ENTRY_DISPLAY[:info_gas_testing_is_missing])[3]
    compare_string('No Entry Yet', no_entry_element.text)
    compare_string('Press on “New Entry” button on the “Home” page to record a new entry.',
                   new_entry_message.text)
  end

  def check_with_new_entry
    click(ENTRY_DISPLAY[:entry_log_btn])
    find_elements(ENTRY_DISPLAY[:entry_log_table])
  end

  def click_new_entry_btn
    click(ENTRY_DISPLAY[:new_entry_button])
  end

  def click_entry_tab(which_tab)
    case which_tab
    when 'entry log'
      click(DASHBOARD_ENTRY_LOG[:entry_log_tab])
    when 'permit'
      click(DASHBOARD_ENTRY_LOG[:permit_tab])
    else
      raise "Wrong condition >>> #{which_tab}"
    end
  end

  def click_home_tab
    click(ENTRY_DISPLAY[:home_tab])
  end

  def check_entrant_count(count)
    if count == '0'
      verify_element_not_exist(ENTRY_DISPLAY[:entrant_count])
    else
      raise "Wrong number of entrants #{count}" unless ENTRY_DISPLAY[:entrant_count].text.eql?(count)
    end
  end

  def check_required_entrants(count)
    while count.to_i.positive?
      ret_required_entrants(count)
      count = count.to_i - 1
    end
  end

  def check_all_log_tbl
    check_log_headers
    check_gas_headers
  end

  def check_new_permit_num(permit_id)
    actual_permit = find_elements(ENTRY_DISPLAY[:generic_data])[2].text
    raise "Wrong permit number #{actual_permit}" unless actual_permit.text.eql?(permit_id)
  end

  def check_timer
    actual_timer = retrieve_text(ENTRY_DISPLAY[:duration_timer])
    raise 'Wrong timer countdown' unless TIMER.any? { |element| actual_timer.include? element }
  end

  def check_response_officer(rank, area)
    retrieve_text(ENTRY_DISPLAY[:resp_off_signature]).eql? 'Responsible Officer Signature:'
    find_elements(ENTRY_DISPLAY[:resp_off_signature_rank])[0].text.eql? 'Rank/Name'
    get_element_by_value(rank, 1)
    get_element_by_value(area, 1)
  end

  private

  def check_log_headers
    table = find_elements(ENTRY_DISPLAY[:header_cell])
    table.first.text.eql? 'Entrant'
    table[1].text.eql? 'Purpose'
    table[2].text.eql? 'Validity'
    table[3].text.eql? 'Time In/Out'
    table[4].text.eql? 'GMT'
  end

  def check_gas_headers
    table = find_elements(ENTRY_DISPLAY[:header_cell])
    table[5].text.eql? 'O2'
    table[6].text.eql? 'HC'
    table[7].text.eql? 'H2S'
    table[8].text.eql? 'CO'
    table[9].text.eql? 'Test'
    table[10].text.eql? 'OOW'
  end

  def ret_required_entrants(count)
    @driver
      .find_element(:xpath,
                    "//*[starts-with(@class,'UnorderedList')]/li[#{count}]")
  end

  def get_element_by_value(element_value_text, count)
    xpath_str = format(ENTRY_DISPLAY[:template_path], element_value_text)
    arr = find_elements(xpath_str)
    arr[count.to_i]
  end

end
