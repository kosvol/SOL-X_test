# frozen_string_literal: true"

require_relative '../base_page'

# Initial create permit object
class CreateEntryPermitPage < BasePage
  include EnvUtils

  attr_accessor :pre_permit_start_time, :pre_permit_end_time, :permit_id, :permit_duration, :temp_id, :permit_number

  CREATE_ENTRY_PERMIT = {
    heading_text: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3",
    permit_validation_btn: "//button[@id='permitValidDuration']",
    current_day_button: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]",
    four_hours_duration: "//button[contains(.,'4 hours')]",
    six_hours_duration: "//button[contains(.,'6 hours')]",
    eight_hours_duration: "//button[contains(.,'8 hours')]",
    view_btn: "//button[contains(.,'View')]",
    permit_end_time_pre: "//section[contains(@class,'Section__SectionMain')][23]/div/div[2]/p",
    permit_start_time_pre: "//section[contains(@class,'Section__SectionMain')][23]/div/div[1]/p",
    permit_start_time_cre: "//section[contains(@class,'Section__SectionMain')][13]/div/div[1]/p",
    permit_end_time_cre: "//section[contains(@class,'Section__SectionMain')][13]/div/div[2]/p",
    form_structure: "//div[contains(@class,'FormFieldCheckButtonGroupFactory__CheckButtonGroupContainer')]/div/span",
    reporting_interval: "//input[@id='pre_section2_reportingIntervalPeriod']",
    pre_creator_form: "//div[contains(@class,'Cell__Description')][1]",
    person_checkbox: "//span[@class='checkbox']",
    enter_pin_and_apply: "//button[contains(.,'Enter Pin & Apply')]",
    entrant_select_btn: "//span[contains(text(),'Select Entrants - Required')]",
    entry_log_btn: "//*[starts-with(@class,'TabNavigator__TabItem')][2]/a/span",
    input_field: "//div[starts-with(@class,'Input')]",
    resp_off_signature: "//h2[contains(.,'Responsible Officer Signature:')]",
    resp_off_signature_rank: "//h3[contains(.,'Rank/Name')]",
    signed_in_entrants: '//div/div/ul/li',
    approve_activation: "//button[contains(.,'Approve for Activation')]",
    smartforms_display_setting: "//span[contains(.,'SmartForms')]",
    purpose_of_entry: "//textarea[@id='reasonForEntry']",
    entrant_names_dd: "//span[contains(.,'Select Other Entrants - Optional')]",
    entry_log_table: "//div[@data-testid='entry-log-column']/div",
    input_field1: "//input[starts-with(@class,'Input')]",
    header_cell: "//div[starts-with(@class,'header-cell')]",
    header_pwt: "//h4[starts-with(@class,'Heading__H4')]",
    clock: '//*[@id="permitActiveAt"]/span',
    confirm_btn: "//button[contains(.,'Confirm')]",
    ptw_id: 'header > h1',
    duration_timer: "//h4/strong[contains(@class,'PermitValidUntil__')]",
    submit_for_approval_btn: "//button[contains(.,'Submit For Approval')]"
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

  def retrieve_permit_id
    self.temp_id = @driver.find_element(:css, CREATE_ENTRY_PERMIT[:ptw_id]).text
    self.permit_id = @driver.find_element(:css, CREATE_ENTRY_PERMIT[:ptw_id]).text
    self.permit_duration = retrieve_text(CREATE_ENTRY_PERMIT[:duration_timer])
    permit_id
    permit_duration
    temp_id
  end

  def click_submit_for_approval
    click(CREATE_ENTRY_PERMIT[:submit_for_approval_btn])
  end

  def verify_reporting_interval(condition)
    if condition == 'enabled'
      compare_string(@driver.find_element(:xpath, CREATE_ENTRY_PERMIT[:reporting_interval]).enabled?.to_s.downcase,
                     true.to_s.downcase)
    else
      verify_element_not_exist(CREATE_ENTRY_PERMIT[:reporting_interval])
    end
  end

  private

  DURATION = {
    '4' => CREATE_ENTRY_PERMIT[:four_hours_duration],
    '6' => CREATE_ENTRY_PERMIT[:six_hours_duration],
    '8' => CREATE_ENTRY_PERMIT[:eight_hours_duration]
  }.freeze

end
