# frozen_string_literal: true"

require_relative '../base_page'

# Initial create permit object
class CreateEntryPermitPage < BasePage
  include EnvUtils

  attr_accessor :pre_permit_start_time, :pre_permit_end_time, :permit_id, :permit_duration, :temp_id, :permit_number,
                :time, :permit_index, :issue_time_date, :selected_date

  CREATE_ENTRY_PERMIT = {
    heading_text: "//*[@id='root']/div/nav/header",
    submit_for_approval_btn: "//*[contains(.,'Submit for Approval')]/parent::button",
    permit_validation_btn: "//button[@id='permitValidDuration']",
    four_hours_duration: "//button[contains(.,'4 hours')]",
    six_hours_duration: "//button[contains(.,'6 hours')]",
    eight_hours_duration: "//button[contains(.,'8 hours')]",
    permit_end_time_pre: "//section[contains(@class,'Section__SectionMain')][23]/div/div[2]/p",
    permit_start_time_pre: "//section[contains(@class,'Section__SectionMain')][23]/div/div[1]/p",
    permit_start_time_cre: "//section[contains(@class,'Section__SectionMain')][13]/div/div[1]/p",
    permit_end_time_cre: "//section[contains(@class,'Section__SectionMain')][13]/div/div[2]/p",
    reporting_interval: "//input[@id='pre_section2_reportingIntervalPeriod']",
    entry_log_table: "//div[@data-testid='entry-log-column']/div",
    clock_element: '//*[@id="permitActiveAt"]/span',
    confirm_btn: "//button[contains(.,'Confirm')]",
    ptw_id: 'header > h1',
    duration_timer: "//h4/strong[contains(@class,'PermitValidUntil__')]",
    current_day: "//button[contains(@class,'Day__DayButton')]",
    next_month_button: "//button[contains(@data-testid,'calendar-next-month')]",
    gas_added_by: 'div[role="dialog"] > div > section > div > span',
    back_to_home_btn: "//button[contains(.,'Back to Home')]",
    picker: "//label[contains(text(),'Start Time')]//following::button[@data-testid='hours-and-minutes']",
    picker_hh: "//div[@class='time-picker']//div[starts-with(@class,'picker')][1]//*[contains(text(),'%s')]",
    picker_mm: "//div[@class='time-picker']//div[starts-with(@class,'picker')][2]//*[contains(text(),'%s')]",
    permit_validity: "//h2[contains(text(),'Permit Validity')]",
    time_element: '//*[@id="permitActiveAt"]'
  }.freeze

  def initialize(driver)
    super
    find_element(CREATE_ENTRY_PERMIT[:heading_text])
  end

  def retrieve_start_end_time(permit_type)
    if permit_type == 'CRE'
      raw_start_time = retrieve_text(CREATE_ENTRY_PERMIT[:permit_start_time_cre])
      raw_end_time = retrieve_text(CREATE_ENTRY_PERMIT[:permit_end_time_cre])
    else
      raw_start_time = retrieve_text(CREATE_ENTRY_PERMIT[:permit_end_time_pre])
      raw_end_time = retrieve_text(CREATE_ENTRY_PERMIT[:permit_end_time_pre])
    end
    self.pre_permit_start_time = raw_start_time[12, 5].to_s
    self.pre_permit_end_time = raw_end_time[12, 5].to_s
  end

  def select_permit_duration(duration)
    scroll_click(CREATE_ENTRY_PERMIT[:permit_validation_btn])
    scroll_times_direction(5, 'down')
    click(DURATION[duration])
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

  def select_next_date(advance_days = 0)
    find_elements(CREATE_ENTRY_PERMIT[:current_day]).each_with_index do |element, index|
      next unless element.attribute('class').include? 'current'

      element_index = index + advance_days + 1
      @driver.find_element("//button[contains(@class,'Day__DayButton')][(#{element_index}]").click
      break
    end
  rescue StandardError
    click(CREATE_ENTRY_PERMIT[:next_month_button])
    find_elements("//button[contains(.,'01')]")[0].click
  end

  def save_time
    self.time = retrieve_text(CREATE_ENTRY_PERMIT[:clock_element])
  end

  def verify_crew_in_popup(rank_name)
    crew_member_actual = @driver.find_element(:css, CREATE_ENTRY_PERMIT[:gas_added_by]).text
    compare_string("By #{rank_name}", crew_member_actual)
  end

  def verify_alert_text(value)
    raise 'Element verify failed' unless find_element("//div[contains(.,'#{value}')]").eql?(true)
  end

  def verify_element_text(value)
    raise 'Element verify failed' unless find_element("//*[contains(text(),'#{value}')]").eql?(true)
  end

  def verify_label(value)
    raise 'Element verify failed' unless find_element("//h2[contains(text(),'#{value}')]").eql?(true)
  end

  def verify_page_text(value)
    raise 'Element verify failed' unless find_element("//h2[contains(text(),'#{value}')]").eql?(true)
  end

  def verify_header(value)
    raise 'Element verify failed' unless find_element("//h1[contains(text(),'#{value}')]").eql?(true)
  end

  def verify_button(value)
    raise 'Element verify failed' unless find_element("//button[contains(.,'#{value}')]").eql?(true)
  end

  def click_back_to_home
    click(CREATE_ENTRY_PERMIT[:back_to_home_btn])
  end

  def click_submit_for_approval
    click(CREATE_ENTRY_PERMIT[:submit_for_approval_btn])
  end

  def click_officer_approval_btn
    xpath_str = "//span[contains(text(),#{permit_id})]//following::span[contains(text(),'Officer Approval)][1]"
    click(xpath_str)
  end

  private

  def picker_hh_mm(delay)
    time = find_element(CREATE_ENTRY_PERMIT[:time_element]).text
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

  DURATION = {
    '4' => CREATE_ENTRY_PERMIT[:four_hours_duration],
    '6' => CREATE_ENTRY_PERMIT[:six_hours_duration],
    '8' => CREATE_ENTRY_PERMIT[:eight_hours_duration]
  }.freeze

end
