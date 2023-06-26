# frozen_string_literal: true

require_relative '../base_page'

# Office Navigation object
class OPNavigationPage < BasePage
  include EnvUtils
  OP_NAVIGATION = {
    heading_text: "//header[starts-with(@class,'MenuHeader')]/div/div/span[contains(., 'Office Portal')]",
    ant_menu: "//ul[starts-with(@class, 'ant-menu')]/li/span[contains(., '%s')]",
    back_arrow: "//span[@aria-label='arrow-left']",
    numb_items: "//span[@class[contains(.,'ant-select-selection-item')]]",
    page_numb: "//li[@class[contains(., 'ant-pagination-item ant-pagination-item-%s')]]",
    select_numb_items: "//div[@title[contains(., '%s')]]",
    arrow_page: "//span[@aria-label='%s']"
  }.freeze

  def initialize(driver)
    super
    wait = Selenium::WebDriver::Wait.new(timeout: 20)
    wait.until { @driver.find_element(:xpath, OP_NAVIGATION[:heading_text]).displayed? }
  rescue StandardError
    raise 'Time out waiting for Office Portal Navigation Menu'
  end

  def navigate_to_page(page)
    link = format(OP_NAVIGATION[:ant_menu], page)
    click(link.to_s)
  end

  def click_back_arr
    click(OP_NAVIGATION[:back_arrow])
  end

  def select_numbers(option)
    click(OP_NAVIGATION[:numb_items])
    click(format(OP_NAVIGATION[:select_numb_items], option))
  end

  def select_num_page(option)
    click(format(OP_NAVIGATION[:page_numb], option))
  end

  def switch_page(option)
    arrow = if option == 'next'
              'right'
            else
              'left'
            end
    click(format(OP_NAVIGATION[:arrow_page], arrow))
  end
end
