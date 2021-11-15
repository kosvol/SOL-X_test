# frozen_string_literal: true"

require_relative '../base_page'

# PRECREBase object
class PRECREBase < BasePage
  include EnvUtils

  attr_accessor :pre_permit_start_time, :pre_permit_end_time, :entrants_arr, :time

  BASE_PRE_CRE = {
    heading_text: "//div[starts-with(@class,'SectionNavigation__NavigationWrapper')]/nav/h3",
    permit_validation_btn: "//button[@id='permitValidDuration']",
    current_day_button: "//button[starts-with(@class,'Day__DayButton') and contains(@class ,'current')]",
    four_hours_duration: "//button[contains(.,'4 hours')]",
    six_hours_duration: "//button[contains(.,'6 hours')]",
    eight_hours_duration: "//button[contains(.,'8 hours')]",
    view_btn: "//button[contains(.,'View')]",
    permit_end_time: "//section[contains(@class,'Section__SectionMain')][23]/div/div[2]/p",
    permit_start_time: "//section[contains(@class,'Section__SectionMain')][23]/div/div[1]/p",
    permit_start_time1: "//section[contains(@class,'Section__SectionMain')][13]/div/div[1]/p",
    permit_end_time1: "//section[contains(@class,'Section__SectionMain')][13]/div/div[2]/p",
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
    gas_O2: "//div[contains(.,'O2')]",
    gas_HC: "//div[contains(.,'HC')]",
    gas_H2S: "//div[contains(.,'H2S')]",
    list_name: "//div[starts-with(.,'EntrantListItem__ListItem')]",
    show_signature_display: "//button[@data-testid='show-signature-display']",
    sign_out_btn: "//span[contains(text(),'Sign Out')]",
    cross_btn: "//button[contains(@class,'Button__ButtonStyled-')]/span",
    options_text: 'div.option-text',
    clock: '//*[@id="permitActiveAt"]/span',
    confirm_btn: "//button[contains(.,'Confirm')]",
    button: "//button[contains(.,'%s')]"
  }.freeze

  def valid_start_end_time=(permit_type)
    if permit_type == 'CRE'
      self.pre_permit_start_time = retrieve_text(BASE_PRE_CRE[:permit_start_time1])
      self.pre_permit_end_time = retrieve_text(BASE_PRE_CRE[:permit_end_time1])
    else
      self.pre_permit_start_time = retrieve_text(BASE_PRE_CRE[:permit_end_time])
      self.pre_permit_end_time = retrieve_text(BASE_PRE_CRE[:permit_end_time])
    end
  end

  def valid_start_details
    pre_permit_start_time[12, 5].to_s
  end

  def valid_end_details
    pre_permit_end_time[12, 5].to_s
  end

  def entrants=(entrants)
    self.entrants_arr= entrants
  end

  def entrants
    entrants_arr
  end

  def signout_entrants(entrants)
    find_elements(BASE_PRE_CRE[:sign_out_btn]).first.click
    (1..entrants.to_i).each do |i|
      find_elements(BASE_PRE_CRE[:cross_btn])[i].click
      find_elements(BASE_PRE_CRE[:sign_out_btn]).last.click
    end
    self.time = BASE_PRE_CRE[:clock].text
  end

  def signout_by_name(entrants)
    entrants_arr = self.entrants
    find_elements(BASE_PRE_CRE[:sign_out_btn]).first.click
    entrants.split(',').each do |i|
      find_element("//*[contains(.,'#{i}')]/button").click
      find_elements(BASE_PRE_CRE[:sign_out_btn]).last.click
      entrants_arr.delete(i)
    end
    self.entrants= (entrants_arr)
    self.time = BASE_PRE_CRE[:clock].text
  end

  def entered_entrant_listed?(entrant)
    click(BASE_PRE_CRE[:entrant_names_dd])
    find_elements_css(BASE_PRE_CRE[:options_text]).each do |crew|
      return false if entrant == crew.text
    end
    true
  end

  def additional_entrant(additional_entrants)
    entr_arr = []
    click(BASE_PRE_CRE[:entrant_names_dd])
    while additional_entrants.positive?
      find_elements_css(BASE_PRE_CRE[:options_text])[additional_entrants].click
      entr_arr.push(find_elements_css(BASE_PRE_CRE[:options_text])[additional_entrants].text)
      additional_entrants -= 1
    end
    self.entrants= (entr_arr)
    find_elements(BASE_PRE_CRE[:confirm_btn]).first.click
  end

  def required_entrants(entrants)
    entr_arr = []
    while entrants.positive?
      find_element("//*[starts-with(@class,'UnorderedList')]/li[#{entrants + 1}]/label/label/span").click
      entr_arr
        .push(find_element("//*[starts-with(@class,'UnorderedList')]/li[#{entrants + 1}]/label/div").text)
      entrants -= 1
    end
    self.entrants= (entr_arr)
  end

  def select_permit_duration(duration)
    scroll_click(BASE_PRE_CRE[:permit_validation_btn])
    scroll_times_direction(5, 'down')
    DURATION[duration]
  end

  def button_enabled?(value)
    element_enabled?(BASE_PRE_CRE[:button], value)
  end

  def button_disabled?(value)
    element_disabled?(BASE_PRE_CRE[:button], value)
  end

  private

  DURATION = {
    4 => BASE_PRE_CRE[:four_hours_duration],
    6 => BASE_PRE_CRE[:six_hours_duration],
    8 => BASE_PRE_CRE[:eight_hours_duration]
  }.freeze

end
