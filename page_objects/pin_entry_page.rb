# frozen_string_literal: true

require_relative '../service/utils/user_service'
require_relative 'base_page'
# PinEntryPage object
class PinEntryPage < BasePage

  PIN_ENTRY = {
    pin_entry_header: "//h2[contains(.,'Please enter your PIN')]",
    pin_pad: '//*[@id="root"]/div/section/main/ol/li[%s]/button',
    error_msg: "//section[@class='pin-indicators-section']/h2"
  }.freeze

  def initialize(driver)
    super
    find_element(PIN_ENTRY[:pin_entry_header])
  end

  def enter_pin(rank)
    pin = retrieve_pin(rank)
    pin_xpath = PIN_ENTRY[:pin_pad]
    pin.each_char do |num|
      xpath = num == '0' ? pin_xpath % '10' : pin_xpath % num
      click(xpath)
    end
  end

  def verify_error_msg(error_msg)
    actual_msg = retrieve_text(PIN_ENTRY[:error_msg])
    compare_string(error_msg, actual_msg)
  end

  private

  def retrieve_pin(rank)
    UserService.new.retrieve_pin_by_rank(rank)
  end
end
