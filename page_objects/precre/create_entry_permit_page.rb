# frozen_string_literal: true"

require_relative '../base_page'
require_relative '../../page_objects/sections/common_section_page'

# Initial create permit object
class CreateEntryPermitPage < BasePage
  include EnvUtils

  attr_accessor :pre_permit_start_time, :pre_permit_end_time, :permit_id, :permit_duration, :temp_id, :permit_number,
                :time, :permit_index, :issue_time_date, :selected_date

  CREATE_ENTRY_PERMIT = {
    heading_text: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3",
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
    back_to_home_btn: "//button[contains(.,'Back to Home')]"
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
    self.permit_duration = retrieve_text(CREATE_ENTRY_PERMIT[:duration_timer])
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
    compare_string(crew_member_actual, "By #{rank_name}")
  end

  def verify_element_and_text(element, value)
    raise 'Element verify failed' unless find_element(format(TYPE_OF_ELEMENT[element.downcase], value)).enabled?
  end

  def click_back_to_home
    click(CREATE_ENTRY_PERMIT[:back_to_home_btn])
  end

  private

  TYPE_OF_ELEMENT = {
    'alert_text' => "//div[contains(.,'%s')]",
    'text' => "//*[contains(text(),'%s')]",
    'auto_terminated' => "//span[contains(.,'%s')]/parent::*//*[contains(.,'Auto Terminated')]",
    'label' => "//h2[contains(text(),'%s')]",
    'page' => "//h2[contains(text(),'%s')]",
    'header' => "//h1[contains(text(),'%s')]",
    'button' => "//button[contains(.,'%s')]"
  }.freeze

  DURATION = {
    '4' => CREATE_ENTRY_PERMIT[:four_hours_duration],
    '6' => CREATE_ENTRY_PERMIT[:six_hours_duration],
    '8' => CREATE_ENTRY_PERMIT[:eight_hours_duration]
  }.freeze

end
