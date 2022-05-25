# frozen_string_literal: true

require_relative '../base_page'

# CommonSectionPage object
class CommonSectionPage < BasePage
  include EnvUtils

  COMMON_SECTION = {
    navigation_header: '//*[@id="navigation-wrapper"]',
    navigation_button: '//*[@id="navigation-wrapper"]/nav/section/button',
    section_option: "//a[contains(.,'%s')]",
    next_btn: "//button[span='Next']",
    save_next_btn: "//button[span='Save & Next']",
    save_btn: "//button[span='Save']",
    previous_btn: "//button[span='Previous']",
    sign_btn: "//button[contains(.,'Sign')]",
    done_button: "//button[span='Done']",
    back_btn: "//button[span='Back']",
    close_btn: "//button[span='Close']",
    parent_container: "//ul[starts-with(@class,'FormsList__Container')]/li",
    save_close_btn: "//button[span='Save & Close']"
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

  def click_save
    click(COMMON_SECTION[:save_btn])
  end

  def click_previous
    click(COMMON_SECTION[:previous_btn])
  end

  def click_sign_sign
    scroll_click(COMMON_SECTION[:sign_btn])
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

  def verify_button(text, option)
    verify_btn_availability("//button[span=\"#{text}\"]", option)
  end

  def verify_header_text(expected_header)
    compare_string(expected_header, retrieve_text('(//h3)[1]'))
  end

  def click_save_close_btn
    click(COMMON_SECTION[:save_close_btn])
  end
end
