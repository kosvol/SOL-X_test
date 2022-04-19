# frozen_string_literal: true

require_relative 'base_page'
require_relative '../service/utils/user_service'

#  add entrants page object
class AddEntrantsPage < BasePage
  include EnvUtils
  attr_accessor :entrants

  ADD_ENTRANTS = {
    header_entry_page: "//h1[contains(.,'New Entry')]",
    confirm_btn: "//button[contains(.,'Confirm')]",
    send_report: "//button[contains(.,'Send Report')]",
    entrant_ddl_btn: "//button[starts-with(@class, 'SelectButton')]",
    entrant_ddl_option: '//*[@class="option-text" and text()="%s"]',
    entrant_list: '//*[@class="option-text"]',
    done_btn: "//button[contains(.,'Done')]"
  }.freeze

  def initialize(driver)
    super
    find_element(ADD_ENTRANTS[:header_entry_page])
    @user_service = UserService.new
  end

  def add_entrants(table)
    click(ADD_ENTRANTS[:entrant_ddl_btn])
    table.raw.each do |rank|
      rank_name = @user_service.retrieve_rank_and_name(rank[0])
      sleep 1
      click(ADD_ENTRANTS[:entrant_ddl_option] % rank_name)
    end
    click(ADD_ENTRANTS[:confirm_btn])
  end

  def click_send_report_btn
    scroll_click(ADD_ENTRANTS[:send_report])
    sleep 0.5
    click(ADD_ENTRANTS[:done_btn])
  end

  def verify_rank_exclude(table)
    click(ADD_ENTRANTS[:entrant_ddl_btn])
    page_options = find_elements(ADD_ENTRANTS[:entrant_list])
    exclude_list = []
    table.raw.each do |rank|
      rank_name = @user_service.retrieve_rank_and_name(rank[0])
      exclude_list.append(rank_name)
    end
    page_options.each do |option|
      raise "#{option} should be exclude" if exclude_list.include? option.text
    end
  end
end
