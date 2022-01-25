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
    active_entrant: "//span[@data-testid='entrant-count']"

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



end
