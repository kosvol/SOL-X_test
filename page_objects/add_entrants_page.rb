# frozen_string_literal: true

require_relative 'base_page'

#  dd entrants page object
class AddEntrantsPage < BasePage
  include EnvUtils
  attr_accessor :entrants

  ADD_ENTRANTS = {
    header_entry_page: "//1[contains(.,'New Entry')]",
    entrant_names: "//span[contains(.,'Select Other Entrants - Optional')]",
    options_text: 'div.option-text',
    confirm_btn: "//button[contains(.,'Confirm')]",
    send_report: "//button[contains(.,'Send Report')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ADD_ENTRANTS[:header_entry_page])
  end

  def add_optional_entrants(entrants_number)
    self.entrants = []
    click(ADD_ENTRANTS[:entrant_names])
    sleep 0.5
    option_text = @driver.find_elements(css: ADD_ENTRANTS[:options_text])
    while entrants_number.positive?
      option_text[entrants_number].click
      entrants.push(option_text[entrants_number].text)
      additional_entrants -= 1
    end
  end

  def add_required_entrants(entrants_number)
    self.entrants = []
    while entrants_number.positive?
      @driver.find_element(:xpath,
                           "//*[starts-with(@class,'UnorderedList')]/li[#{entrants_number + 1}]/label/label/span").click
      entrants.push(@driver
                      .find_element(:xpath,
                                    "//*[starts-with(@class,'UnorderedList')]/li[#{entrants_number + 1}]/label/div").text)
      entrants_number -= 1
    end
  end

  def click_confirm_btn
    click(ADD_ENTRANTS[:confirm_btn])
  end

  def click_send_report_btn
    click(ADD_ENTRANTS[:send_report])
  end


end
