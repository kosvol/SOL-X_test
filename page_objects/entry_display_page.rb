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
    permit_tab: "//a[contains(.,'Permit')]"
  }.freeze

  BACKGROUND_COLOR = {
    green: 'rgba(216, 75, 75, 1)',
    red: 'rgba(67, 160, 71, 1)'
  }.freeze

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

end
