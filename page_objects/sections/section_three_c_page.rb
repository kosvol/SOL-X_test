# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/utils/user_service'

# SectionThreeCPage object
class SectionThreeCPage < BasePage
  include EnvUtils
  SECTION_THREE_C = {
    section_header: "//h3[contains(.,'Section 3C: DRA - Team Members')]",
    save_next_btn: "//button[contains(.,'Save & Next')]",
    previous_btn: "//button[contains(.,'Previous')]",
    default_dra_member: "(//div[starts-with(@class,'ValueTree__ValueTreeNodeWrapper')])[1]",
    selected_dra_list: "//div[starts-with(@class,'ValueTree__ValueTreeNodeWrapper')]",
    edit_selection: '//button[@id="team"]',
    member_options: "//div[contains(@class, 'option-text') and text() = '%s']",
    selection_confirm_btn: "//button[contains(.,'Confirm')]",
    delete_btn: "//div[starts-with(@class,'ValueTree__ValueTreeNodeWrapper') and text() = '%s']/button"
  }.freeze

  def initialize(driver)
    super
    find_element(SECTION_THREE_C[:section_header])
    @user_service = UserService.new
  end

  def verify_default_dra_member(rank)
    expected = @user_service.retrieve_rank_and_name(rank)
    actual = retrieve_text(SECTION_THREE_C[:default_dra_member])
    compare_string(expected, actual)
  end

  def add_dra_member(rank)
    click(SECTION_THREE_C[:edit_selection])
    sleep 0.5
    rank_name = @user_service.retrieve_rank_and_name(rank)
    click(SECTION_THREE_C[:member_options] % rank_name)
    click(SECTION_THREE_C[:selection_confirm_btn])
  end

  def remove_dra_member(rank)
    rank_name = @user_service.retrieve_rank_and_name(rank)
    click(SECTION_THREE_C[:delete_btn] % rank_name)
  end

  def verify_dra_member_list(rank_list)
    selected_dra_element = find_elements(SECTION_THREE_C[:selected_dra_list])
    rank_list.raw.each_with_index do |rank, index|
      WAIT.until { selected_dra_element[index].displayed? }
      compare_string(@user_service.retrieve_rank_and_name(rank.first), selected_dra_element[index].text)
    end
  end
end
