# frozen_string_literal: true


require_relative '../base_page'
require_relative 'create_entry_permit_page'

# CompressorRoomPage object
class CompressorRoomPage < CreateEntryPermitPage
  include EnvUtils
  COMPRESSOR_ROOM = {
    cre_header: "//*[contains(text(),'Section 1: Compressor Room Entry Permit')]",
    cre_scrap: "//div/*/*[local-name()='span' or local-name()='label']",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]",
    button_sample: "//span[contains(.,'%s')]",
    text_area: '//textarea',
    gas_added_by: 'div[role="dialog"] > div > section > div > span',
    ptw_id: 'header > h1'
  }.freeze

  def initialize(driver)
    super
    find_element(COMPRESSOR_ROOM[:cre_header])
  end

  def fill_cre_form(duration)
    tmp_elements = find_elements(COMPRESSOR_ROOM[:text_area])
    tmp_elements.each do |element|
      element.send_keys('Test Automation')
    end
    click(format(COMPRESSOR_ROOM[:button_sample], ['At Sea', 'In Port'].sample).to_s)
    select_permit_duration(duration)
  end

  def verify_titles_and_questions
    titles_and_questions_arr = []
    find_elements('//h4').each do |field|
      titles_and_questions_arr << field.text
    end
    base_titles_and_questions =
      [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['titles_and_questions']
    raise 'Verify failed' unless (titles_and_questions_arr - base_titles_and_questions) != []
  end

  def verify_titles_of_sections
    titles_of_sections = []
    find_elements('//h2').each do |field|
      titles_of_sections << field.text
    end
    base_titles_of_sections =
      [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['titles_of_sections']
    raise 'Verify failed' unless (titles_of_sections - base_titles_of_sections) != []
  end

  def verify_answers_of_sections_one
    answers_for_section = []
    find_elements('//span').each do |field|
      answers_for_section << field.text
    end
    base_answers_first_section =
      [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['answears_first_section']
    raise 'Verify failed' unless
      ((answers_for_section & base_answers_first_section).any? { |x| base_answers_first_section.include?(x) }) != true
  end

  def verify_answers_of_sections_two
    answers_for_sections = retrieve_answers_for_sections
    base_entry_titles = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['entry_titles']
    raise 'Verify failed' unless (answers_for_sections & base_entry_titles) == base_entry_titles
  end

  def verify_gas_sections
    answers_for_sections = retrieve_answers_for_sections
    base_gas_section = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['gas_section']
    raise 'Verify failed' unless (answers_for_sections & base_gas_section) == base_gas_section
  end

  def verify_cre_section_title(text, condition)
    if condition == true
      raise 'Verify failed' unless find_element(CREATE_ENTRY_PERMIT[:heading_text]).text.eql?(text) == false
    else
      raise 'Verify failed' unless find_element(CREATE_ENTRY_PERMIT[:heading_text]).text.eql?(text) == true
    end
  end

  def verify_gas_added_by(text)
    gas_added_by_actual = @driver.find_element(:css, COMPRESSOR_ROOM[:gas_added_by]).text
    raise 'Verify failed' unless gas_added_by_actual.eql?(text) == false
  end

  def verify_permit_not_in_list
    permit_number_actual = @driver.find_element(:css, COMPRESSOR_ROOM[:ptw_id]).text
    raise 'Verify failed' unless permit_number_actual.eql?(permit_number) == false
  end

  private

  def retrieve_answers_for_sections
    answers_for_section_second = []
    find_elements('//label').each do |field|
      answers_for_section_second << field.text
    end
    answers_for_section_second
  end

end
