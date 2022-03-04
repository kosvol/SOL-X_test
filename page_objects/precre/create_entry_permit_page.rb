# frozen_string_literal: true

require_relative '../base_page'

# Initial create permit object
class CreateEntryPermitPage < BasePage
  include EnvUtils

  attr_accessor :permit_id, :permit_duration, :temp_id, :permit_index, :issue_time_date, :selected_date

  CREATE_ENTRY_PERMIT = {
    heading_text: "//*[@id='root']/div/nav/header",
    submit_for_approval_btn: "//*[contains(.,'Submit for Approval')]/parent::button",
    permit_validation_btn: "//button[@id='permitValidDuration']",
    reporting_interval: "//input[@id='pre_section2_reportingIntervalPeriod']",
    clock_element: '//*[@id="permitActiveAt"]/span',
    ptw_id: 'header > h1',
    current_day: "//button[contains(@class,'Day__DayButton')]",
    next_month_button: "//button[contains(@data-testid,'calendar-next-month')]",
    gas_added_by: 'div[role="dialog"] > div > section > div > span',
    back_to_home_btn: "//button[contains(.,'Back to Home')]",
    picker: "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']",
    picker_hh: "//div[@class='time-picker']//div[starts-with(@class,'picker')][1]//*[contains(text(),'%s')]",
    picker_mm: "//div[@class='time-picker']//div[starts-with(@class,'picker')][2]//*[contains(text(),'%s')]",
    time_element: '//*[@id="permitActiveAt"]',
    ptw_id_in_list: "//ul[starts-with(@class,'FormsList__Container')]/li/span"
  }.freeze

  def initialize(driver)
    super
    find_element(CREATE_ENTRY_PERMIT[:heading_text])
  end

  def select_permit_duration(duration)
    scroll_click(CREATE_ENTRY_PERMIT[:permit_validation_btn])
    scroll_times_direction(5, 'down')
    click("//button[contains(.,'#{duration} hours')]")
  end

  def save_permit_id
    self.temp_id = @driver.find_element(:css, CREATE_ENTRY_PERMIT[:ptw_id]).text
    self.permit_id = @driver.find_element(:css, CREATE_ENTRY_PERMIT[:ptw_id]).text
  end

  def verify_reporting_interval(condition)
    scroll_times_direction(1, 'down')
    if condition == 'should'
      reporting_interval = find_element(CREATE_ENTRY_PERMIT[:reporting_interval])
      raise 'reporting interval verify failed' unless reporting_interval.enabled?
    else
      verify_element_not_exist(CREATE_ENTRY_PERMIT[:reporting_interval])
    end
  end

  def verify_crew_in_popup(rank_name)
    crew_member_actual = @driver.find_element(:css, CREATE_ENTRY_PERMIT[:gas_added_by]).text
    compare_string("By #{rank_name}", crew_member_actual)
  end

  def verify_element_text(value)
    raise 'Element verify failed' unless find_element("//*[contains(text(),'#{value}')]")
  end

  def verify_page_text(value)
    raise 'Element verify failed' unless find_element("//h2[contains(text(),'#{value}')]")
  end

  def click_back_to_home
    click(CREATE_ENTRY_PERMIT[:back_to_home_btn])
  end

  def click_submit_for_approval
    click(CREATE_ENTRY_PERMIT[:submit_for_approval_btn])
  end

  def click_officer_approval_btn
    xpath_str = "//span[contains(.,'#{permit_id}')]/parent::li/div[3]/button[1]"
    click(xpath_str)
  end

  def permit_from_indexed_db
    permit_from_db = WorkWithIndexeddb.get_id_from_indexeddb(permit_id)
    self.permit_id = permit_from_db
  end

  def verify_permit_in_indexed_db
    permit_from_db = WorkWithIndexeddb.get_id_from_indexeddb(permit_id)
    raise 'Permanent permit number not been generated' unless permit_from_db.eql?('')
  end

  def save_ptw_id_from_list
    self.permit_id = find_element(CREATE_ENTRY_PERMIT[:ptw_id_in_list]).text
  end

  def verify_permit
    raise 'Permit id verify fail' unless find_element("//*[contains(text(),'#{permit_id}')]")
  end

  private

  def picker_hh_mm(delay)
    time = find_elements(CREATE_ENTRY_PERMIT[:time_element]).last.text
    hh, mm = add_minutes(time, delay)
    picker_hh = format(CREATE_ENTRY_PERMIT[:picker_hh], hh)
    picker_mm = format(CREATE_ENTRY_PERMIT[:picker_mm], mm)
    [picker_hh, picker_mm]
  end

  def add_minutes(time, add_mm)
    hh, mm = time.split(':')
    mm = mm.to_i
    hh = hh.to_i
    mm += add_mm.to_i
    if mm >= 60
      mm -= 60
      hh += 1
    end
    [format('%02d', hh), format('%02d', mm)]
  end
end
