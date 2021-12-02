# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/utils/user_service'

# SectionFivePage object
class SectionFivePage < BasePage
  include EnvUtils
  SECTION_FIVE = {
    section_header: "//h3[contains(.,'Section 5: Responsibility Acceptance')]",
    role_ddl_btn: '(//button[@type="button"])[1]',
    role_ddl_option: '//*[@class="option-text" and text()="%s"]',
    confirm_btn: "//button[contains(.,'Confirm')]",
    sign_btn: "(//button[contains(.,'Sign')])[1]",
    role_headings: '(//*[@class="responsibility-container"]/div/h3)[%s]',
    rank_name: "(//*[starts-with(@class, 'Text')])[%s]",
    location_stamp: "(//*[starts-with(@class, 'AnswerComponent')])[%s]",
    role_list: "(//*[starts-with(@class, 'ValueTree')])",
    signature_list: '//*[@data-testid="responsibility-box"]/h3',
    role_options: '//div[@class="option-text"]',
    non_crew_checkbox: '//*[@class="checkbox"]',
    other_name: '//*[@id="otherName"]',
    other_company: '//*[@name="otherCompany"]',
    non_crew_text: '//*[@id="root"]/div/main/form/section/div/section[2]/div/div/ul/li/div[3]/span',
    supervised_by: "(//*[starts-with(@class, 'Text')])[1]",
    signed_name: "(//*[starts-with(@class, 'Text')])[2]",
    signed_company: "(//*[starts-with(@class, 'Text')])[4]"
  }.freeze

  NON_CREW_TEXT = 'Ship Staff to use PIN for non-crew member to enter signature'

  def initialize(driver)
    super
    find_element(SECTION_FIVE[:section_header])
  end

  def select_role(table)
    click(SECTION_FIVE[:role_ddl_btn])
    table.raw.each do |role_option|
      click(SECTION_FIVE[:role_ddl_option] % role_option)
    end
    click(SECTION_FIVE[:confirm_btn])
  end

  def click_sign_btn
    scroll_click(SECTION_FIVE[:sign_btn])
  end

  def verify_signature(table)
    element_index = 1
    user_service = UserService.new
    table.hashes.each do |row|
      compare_string(row['role'], retrieve_text(SECTION_FIVE[:role_headings] % element_index))
      expected_rank_name = user_service.retrieve_rank_and_name(row['rank'])
      compare_string(expected_rank_name, retrieve_text(SECTION_FIVE[:rank_name] % element_index))
      element_index += 2
    end
  end

  def delete_role(table)
    table.raw.each do |row|
      click("//*[text()='#{row.first}']/button")
    end
  end

  def verify_role_list(list_type, table)
    role_elements = find_elements(SECTION_FIVE[list_type.to_sym])
    table.raw.each_with_index do |row, index|
      compare_string(row.first, role_elements[index].text)
    end
  end

  def verify_full_role_list
    expected_list = YAML.load_file('data/roles_responsibilities.yml')['roles']
    click(SECTION_FIVE[:role_ddl_btn])
    sleep 2 # have to wait for all roles to be loaded
    option_elements = find_elements(SECTION_FIVE[:role_options])
    option_elements.each_with_index do |element, index|
      compare_string(expected_list[index], element.text)
    end
  end

  def click_non_crew_checkbox
    click(SECTION_FIVE[:non_crew_checkbox])
  end

  def verify_sign_btn(option)
    sign_btn_element = find_element(SECTION_FIVE[:sign_btn])
    if option == 'enabled'
      raise 'sign btn is disabled' unless sign_btn_element.enabled?
    elsif sign_btn_element.enabled?
      raise 'sign btn is enabled'
    end
  end

  def enter_non_crew_info(table)
    values = table.hashes.first
    enter_text(SECTION_FIVE[:other_name], values['name'])
    enter_text(SECTION_FIVE[:other_company], values['company'])
  end

  def verify_non_crew_hint
    compare_string(NON_CREW_TEXT, retrieve_text(SECTION_FIVE[:non_crew_text]))
  end

  def verify_supervised_signature(table)
    expected_values = table.hashes.first
    expected_supervised = UserService.new.retrieve_rank_and_name(expected_values['rank'])
    compare_string(expected_supervised, retrieve_text(SECTION_FIVE[:supervised_by]))
    compare_string(expected_values['role'], retrieve_text(SECTION_FIVE[:role_headings] % '1'))
    verify_signed_columns(expected_values)
  end

  def verify_signature_list(table)

    role_elements = find_elements(SECTION_FIVE[:role_list])
    table.raw.each_with_index do |row, index|
      compare_string(row.first, role_elements[index].text)
    end


    table.hashes.each do |row|
      compare_string(row['role'], retrieve_text(SECTION_FIVE[:role_headings] % element_index))
    end
  end

  private

  def verify_signed_columns(expected_values)
    compare_string(expected_values['name'], retrieve_text(SECTION_FIVE[:signed_name]))
    compare_string(expected_values['company'], retrieve_text(SECTION_FIVE[:signed_company]))
  end
end
