# frozen_string_literal: true

require_relative '../base_page'

# CommonSectionPage object
class CommonSectionPage < BasePage
  include EnvUtils

  attr_accessor :ptw_id, :tmp_id

  COMMON_SECTION = {
    navigation_header: '//*[@id="navigation-wrapper"]',
    navigation_button: '//*[@id="navigation-wrapper"]/nav/section/button',
    section_option: "//a[contains(.,'%s')]",
    next_btn: "//button[contains(.,'Next')]",
    save_next_btn: "//button[contains(.,'Save & Next')]",
    previous_btn: "//button[contains(.,'Previous')]",
    sign_btn: "//button[contains(.,'Sign')]",
    done_button: "//button[contains(.,'Done')]",
    back_btn: "//button[contains(.,'Back')]",
    close_btn: "//button[contains(.,'Close')]",
    view_btn: "//button[contains(.,'View')]",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    ptw_id: 'header > h1',
    resp_of_signature: "//h2[contains(.,'Responsible Officer Signature:')]",
    resp_of_sig_rank: "//h3[contains(.,'Rank/Name')]",
    ptw_id_in_list: "//ul[starts-with(@class,'FormsList__Container')]/li/span",
  }.freeze

  def initialize(driver)
    super
    find_element(COMMON_SECTION[:navigation_header])
  end

  def navigate_to_section(section)
    click(COMMON_SECTION[:navigation_button])
    sleep 0.5 # will find the way to remove
    scroll_click(COMMON_SECTION[:section_option] % section)
  end

  def click_next_btn
    click(COMMON_SECTION[:next_btn])
  end

  def click_save_next
    click(COMMON_SECTION[:save_next_btn])
  end

  def click_previous
    click(COMMON_SECTION[:previous_btn])
  end

  def click_sign_sign
    click(COMMON_SECTION[:sign_btn])
  end

  def click_done_dialog
    find_elements(COMMON_SECTION[:done_button]).first.click
  end

  def click_back_btn
    click(COMMON_SECTION[:back_btn])
  end

  def click_close_btn
    click(COMMON_SECTION[:close_btn])
  end

  def open_ptw_for_view
    permit_index = retrieve_permit_index(CreateEntryPermitPage.permit_id)
    find_elements(COMMON_SECTION[:view_btn])[permit_index].click
  end

  def verify_button_disabled(text)
    raise 'Element enabled' unless find_element("//*[contains(.,'#{text}')]").enabled?.eql?(false)
  end

  def verify_button_enabled(text)
    raise 'Element disabled' unless find_element("//*[contains(.,'#{text}')]").enabled?
  end

  def check_ra_signature(rank, location)
    compare_string(retrieve_text(COMMON_SECTION[:resp_of_signature]), 'Responsible Officer Signature:')
    compare_string(retrieve_text(COMMON_SECTION[:resp_of_sig_rank]), 'Rank/Name')
    verify_element_not_exist("//*[contains(.,'#{rank}')]")
    verify_element_not_exist("//*[contains(.,'#{location}')]")
  end

  def save_ptw_id_from_list
    self.tmp_id = find_element(COMMON_SECTION[:ptw_id_in_list]).text
    self.ptw_id = find_element(COMMON_SECTION[:ptw_id_in_list]).text
  end

  def verify_permit
    raise 'Element verify failed' unless find_element("//*[contains(text(),'#{ptw_id}')]")
  end

  private

  def retrieve_permit_index(permit_id)
    permit_index = nil
    find_elements(COMMON_SECTION[:parent_container]).each_with_index do |_permit, index|
      next unless @driver.find_elements(:css, COMMON_SECTION[:ptw_id])[index].text == permit_id

      permit_index = index
      break
    end
    permit_index
  end
end

