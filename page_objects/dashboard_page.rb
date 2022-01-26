# frozen_string_literal: true

require_relative 'base_page'

# DashboardPage object
class DashboardPage < BasePage
  include EnvUtils
  attr_accessor :date_and_time

  DASHBOARD = {
    hamburger_menu_btn: "//nav[starts-with(@class,'NavigationBar__NavBar-')]/header/button",
    crew_finder: "//h2[contains(.,'Crew Finder')]",
    view_log_button: "//div[starts-with(@class,'ActiveEntrantIndicator__ButtonContent')]",
    entry_log_title: "//div[starts-with(@class,'EntryLogDisplay__EntryLogs')]/h2",
    active_entrant: "//span[@data-testid='entrant-count']",
    warning_box: "//*[contains(@class, 'WarningBox__AlertWrapper')][3]",
    gas_alert: "div[data-testid='gas-reader-alert'] > div > section > h2",
    gas_alert_accept_new: "//span[contains(.,'Accept New Reading')]",
    gas_alert_discard_new: '//span[contains(.,"Terminate Current Permit")]',
    gas_close_btn: "button[aria-label='Close']"
  }.freeze

  def open_page
    @driver.get(retrieve_env_url)
    find_element(DASHBOARD[:crew_finder])
  end

  def open_new_page
    @driver.execute_script('window.open()')
    @driver.switch_to.window(@driver.window_handles.last)
  end

  def switch_browser_tab(condition)
    case condition
    when 'last'
      @driver.switch_to.window(@driver.window_handles.last)
    when 'first'
      @driver.switch_to.window(@driver.window_handles.first)
    else
      raise "Wrong condition >>> #{condition}"
    end
  end

  def click_view_log_btn
    click(DASHBOARD[:ese_log_button])
  end

  def save_check_log_date(condition)
    case condition
    when 'save'
      current = DateTime.now.strftime('%Y-%m-%d')
      self.date_and_time = (current)
    when 'check'
      data = date_and_time
      raise 'date time verification fail' unless retrieve_text(DASHBOARD[:entry_log_title]) == DateTime.parse(data[0])
    else
      raise 'wrong action'
    end
  end

  def check_active_entrants(entrant_number)
    active_entrants = retrieve_text(DASHBOARD[:active_entrant])
    raise 'Wrong entrants number' unless active_entrants.to_s == entrant_number
  end

  def verify_error_msg(error_msg)
    actual_msg = retrieve_text(DASHBOARD[:warning_box])
    raise "Verification failed, error message #{error_msg} not presents on screen" unless actual_msg.include? error_msg
  end

  def verify_text_not_present(text)
    verify_element_not_exist(format("//div[contains(.,'%s')]", text).to_s)
  end

  def verify_ackn_message
    @driver.find_element(:css, DASHBOARD[:gas_alert])
    find_element(DASHBOARD[:gas_alert_accept_new])
    find_element(DASHBOARD[:gas_alert_discard_new])
    @driver.find_element(:css, DASHBOARD[:gas_close_btn])
  end

  def click_discard_gr
    click(DASHBOARD[:gas_alert_discard_new])
  end

  def click_close_gas_msg
    @driver.find_element(:css, DASHBOARD[:gas_close_btn]).click
  end



end
