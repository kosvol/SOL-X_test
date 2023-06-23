# frozen_string_literal: true

require_relative '../base_page'

# OPModalWindow objects
class OPModalWindow < BasePage
  include EnvUtils

  OP_MODAL_WINDOW = {
    header: "//div[@class[contains(.,'ant-modal')]]",
    custom_button: "//button[contains(., '%s')]",
    pop_button: "//div[@class[contains(.,'ant-modal')]]/button[contains(., '%s')]",
    pop_message: "//div[@class[contains(.,'ant-modal')]]/following::span[text()='%s']",
    pop_list: "//div[@class[contains(.,'ant-modal')]]/following::li[text()='%s']"
  }.freeze

  def initialize(driver)
    super
    find_element(OP_MODAL_WINDOW[:header])
  end

  def verify_popup(table)
    values = table.hashes.first
    find_element(format(OP_MODAL_WINDOW[:pop_message], values['title'])) if values['title'] != ''
    find_element(format(OP_MODAL_WINDOW[:pop_message], values['message'])) if values['message'] != ''
    find_element(format(OP_MODAL_WINDOW[:pop_list], values['list'])) if values['list'] != ''
  end

  def verify_popup_button
    find_element(format(OP_MODAL_WINDOW[:custom_button], 'Cancel'))
    find_element(format(OP_MODAL_WINDOW[:custom_button], 'Confirm'))
  end

  def pop_click_button(button)
    click(format(OP_MODAL_WINDOW[:pop_button], button))
  end
end
