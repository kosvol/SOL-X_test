# frozen_string_literal: true

require './././support/env'
require 'date'

class OAPage < Section9Page
  include PageObject

  element(:sol_logo, xpath: "//nav[contains(@class,'NavigationBar')]//img[@alt='SOL-X']")
  element(:xxx, xpath: "//label[contains(.,'Your comments to the ship')]")
  button(:approve_permit_btn, xpath: "//button[contains(.,'Approve This Permit')]")
  button(:update_permit_btn, xpath: "//button[contains(.,'Request Updates')]")
  button(:permit_has_been_btn, xpath: "//button[contains(.,'This Permit Has Been')]")
  element(:update_comments, xpath: "//textarea[contains(@id,'comment')]")
  button(:add_comments_btn, xpath: "//button[contains(.,'Add Comments')]")
  button(:comments_cross_icon_btn, xpath: "//div[starts-with(@class,'CommentsSidebar__Container')]/header/button")
  button(:add_comments_btn1, xpath: "//button[contains(.,'Show Comments')]")
  button(:send_comments_btn, xpath: "//button[contains(.,'Send')]")
  button(:see_more_less_btn, xpath: "//button[contains(text(),'See')]")
  elements(:date_time_from, xpath: "//button[@id='date-from']")
  elements(:date_time_to, xpath: "//button[@id='date-to']")
  elements(:to_date_calender, xpath: "//button[starts-with(@class,'Day__DayButton-')]")
  elements(:yes_to_checkbox, xpath: "//input[starts-with(@value,'yes')]")
  list_items(:hour_from_picker, xpath: "//div[starts-with(@class,'picker')][1]/ul/li")
  list_items(:minute_from_picker, xpath: "//div[starts-with(@class,'picker')][2]/ul/li")

  element(:dismiss_picker, xpath: "//div[starts-with(@class,'TimePicker__OverlayContainer-')]")
  element(:warning_link_expired, xpath: "//div[contains(@class, 'WarningLinkExpired')]")

  ## Web Confirmation Page
  element(:main_header, xpath: "//h2[contains(@class, 'Heading__H2')]")
  element(:main_description, xpath: "//section[contains(@class, 'Section__SectionMain')]")
  elements(:confirmation_question, xpath: '//ul/li')
  elements(:radio_button, xpath: "//input[starts-with(@type,'radio')]")
  element(:text_area_header, xpath: "//div[contains(@class, 'Textarea')]/label")
  text_area(:instruction_text_area, xpath: "//textarea[@placeholder='Optional']")
  element(:name_input_field, xpath: "//input[@type='text']")
  button(:designation_dd_btn, xpath: "//button[@name='designation']")
  element(:bottom_hint, xpath: "//section[@class='hint']/p")
  element(:warning_infobox, xpath: "//div[contains(@class, 'InfoBox__')]")
  # #End Web Confirmation Page ###

  ## Comment elements ###
  element(:comment_counter, xpath: "//div[starts-with(@class,'CommentsSidebar__Container')]/header/h3")
  element(:comment_box, xpath: "//section[starts-with(@class,'CommentsSection__Section')]/p")
  text_area(:comment_input_box, xpath: "//textarea[@placeholder='Type your comments here...']")
  text_field(:name_box, xpath: "//input[@id='user-name']")
  button(:rank_dd_list, xpath: "//button[@id='rank']")
  elements(:designation, xpath: "//ul[contains(@class,'UnorderedList')]/li")
  element(:comments, xpath: "//li[contains(@data-testid,'comment-message')]")
  element(:comment_bottom_notification, xpath: "//div[contains(@class,'CommentForm')]")
  @@comment_base = 'Head, Fleet Operations (Backup)
  Test Automation
  %s %s (GMT+0)
  Test Automation'
  ## END Comment elements ###

  ## Comment attributes ###
  # before Termination #
  elements(:comment_rank, xpath: "//div[@class='message-rank']")
  elements(:comment_name, xpath: "//div[@class='message-name']")
  elements(:comment_date, xpath: "//div[@class='message-date']")
  elements(:comment_text, xpath: "//li[contains(@data-testid,'comment-message')]/div[3]")
  # after Termination #
  element(:approval_comments_block, xpath: "//div[@class='screen-only']//h2[contains(text(),'Approval Comments')]")
  elements(:comment_rank_after_term, xpath: "//div[@class='screen-only']//div[@class='message-rank']")
  elements(:comment_name_after_term, xpath: "//div[@class='screen-only']//div[@class='message-name']")
  elements(:comment_date_after_term, xpath: "//div[@class='screen-only']//time")
  elements(:comment_text_after_term, xpath: "//div[@class='screen-only']//div[@class='sender-info']/../div[3]")
  ## END Comment attributes ###

  def sol_6553
    sleep 5
    approve_permit_btn_element.click
    select_yes_on_checkbox

    sleep 1
    BrowserActions.scroll_down(date_time_from_elements[0])
    current_hour = get_current_hour
    ### set from time
    date_time_from_elements[1].click
    hour_from_picker_elements.first.click
    minute_from_picker_elements.first.click
    ### set to time
    dismiss_picker_element.click
    sleep 1
    BrowserActions.js_click("//textarea[contains(@placeholder,'Optional')]")
    sleep 1
    date_time_to_elements[1].click
    select_to_hour_minutes(1, 0)
    dismiss_picker_element.click
    sleep 1
    BrowserActions.js_click("//textarea[contains(@placeholder,'Optional')]")
    date_time_to_elements.first.click
    sleep 1
    set_designation
    sleep 2
    BrowserActions.js_click("//button[contains(.,'Approve This Permit to Work')]")
    sleep 2
    $browser.get(EnvironmentSelector.get_environment_url)
    sleep 1
    BrowserActions.wait_until_is_visible(click_create_permit_btn_element)
  end

  def navigate_to_oa_link
    tmp = OfficeApproval.get_office_approval_link(CommonPage.get_permit_id, 'VS', 'VS Automation').to_s
    Log.instance.info "OA Link : #{tmp}"
    tmp
  end

  def set_from_to_details
    sleep 1
    BrowserActions.scroll_down(date_time_from_elements[0])
    scroll_multiple_times_with_direction(3, 'down')
    ### set from time
    date_time_from_elements[1].click
    starttime = Time.now.utc.strftime('%k').to_i + 1
    if starttime <= 23
      hour_from_picker_elements[starttime].click
      sleep 1
      minute_from_picker_elements[1].click
      dismiss_picker_element.click
      sleep 1
      BrowserActions.js_click("//textarea[contains(@placeholder,'Optional')]")
      p " #{starttime}"
    else
      hour_from_picker_elements[starttime - 24].click
      sleep 1
      minute_from_picker_elements[1].click
      sleep 1
      dismiss_picker_element.click
      sleep 1
      BrowserActions.js_click("//textarea[contains(@placeholder,'Optional')]")
      p " #{starttime - 24}"
      date_time_to_elements.first.click
      sleep 1
      p ">> #{current_day_elements.size}"
      select_todays_date_from_calendar(1)
    end

    ### set to time
    sleep 2
    date_time_to_elements[1].click
    sleep 2
    endtime = Time.now.utc.strftime('%k').to_i + 9
    if endtime <= 23
      hour_from_picker_elements[endtime].click
      sleep 1
      minute_from_picker_elements[1].click
      sleep 1
      dismiss_picker_element.click
      sleep 1
      BrowserActions.js_click("//textarea[contains(@placeholder,'Optional')]")
      p " #{endtime}"
    else
      hour_from_picker_elements[endtime - 24].click
      sleep 1
      minute_from_picker_elements[1].click
      sleep 1
      dismiss_picker_element.click
      sleep 1
      BrowserActions.click_xpath_native("//textarea[contains(@placeholder,'Optional')]")
      p " #{endtime - 24}"
      date_time_to_elements.first.click
      sleep 1
      p ">> #{current_day_elements.size}"
      select_todays_date_from_calendar(1)
    end
  end

  def set_to_date_plus_one_day(_current_date)
    BrowserActions.enter_text(issue_to_date_btn_element, (Date.today + 1).strftime('%d/%m/%Y').to_s)
  end

  def is_comment_box_reset?
    puts comment_counter_element.text
    (comment_counter_element.text == 'Comments (0)' && comment_box_element.text == 'This Permit has no comments')
  end

  def set_comment
    BrowserActions.enter_text(enter_comment_box_element, 'Test Automation')
    BrowserActions.enter_text(name_box_element, 'Test Automation')
    sleep 1
    rank_dd_list
    sleep 1
    list_permit_type_elements.last.click
    sleep 1
    send_comments_btn
    sleep 1
    comment_counter_element.text == 'Comments (1)'
  end

  def select_yes_on_checkbox
    sleep 1
    yes_to_checkbox_elements.each(&:click)
  end

  def set_designation
    # designation
    @browser.find_element(:xpath, "//button[@name='designation']").click
    sleep 2
    BrowserActions.scroll_down
    @browser.find_element(:xpath, "//button[contains(.,'VS')]").click
  end

  def is_designation_list?
    tmp_arr = []
    designation_elements.each do |element|
      tmp_arr << element.text
    end
    tmp_arr == YAML.load_file('data/office-approval/designation-list.yml')['roles']
  end

  private

  def add_instruction
    false
  end

  def select_to_hour_minutes(hour_index, minute_index)
    sleep 2
    select_to_hour(hour_index)
    sleep 1
    select_to_minute(minute_index)
    sleep 1
  end

  def select_to_hour(hour_index)
    BrowserActions.js_clicks("//div[starts-with(@class,'picker')][1]/ul/li", hour_index)
  end

  def select_to_minute(minute_index)
    BrowserActions.js_clicks("//div[starts-with(@class,'picker')][2]/ul/li", minute_index)
  end
end
