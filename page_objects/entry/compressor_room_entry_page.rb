# frozen_string_literal: true

require_relative '../base_page'

# CompressorRoomEntryPage object
class CompressorRoomEntryPage < BasePage
  include EnvUtils
  COMPRESSOR_ROOM = {
    heading_text: "//*[@id='root']/div/nav/header",
    cre_header: "//*[contains(text(),'Compressor/Motor Room Entry')]",
    cre_scrap: "//div/*/*[local-name()='span' or local-name()='label']",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]",
    loc_radio_button: "//span[contains(.,'%s')]",
    location_question: "//span[contains(text(),'%s')]/following::*[1]/label",
    radio_button: "//div[starts-with(@class,'RadioButton__')]/label/span/span[contains(.,'%s')]",
    text_area: '//textarea',
    gas_added_by: 'div[role="dialog"] > div > section > div > span',
    ptw_id: 'header > h1',
    duration_dd_btn: "//button[@id='permitValidDuration']",
    dd_list_value: "//ul[starts-with(@class,'UnorderedList-')]/li/button/div[contains(text(),'%s')]",
    terminate_btn: "//button[span='Terminate']"
  }.freeze

  def initialize(driver)
    super
    find_element(COMPRESSOR_ROOM[:heading_text])
  end

  def fill_text_area
    all_page_text_areas = find_elements(COMPRESSOR_ROOM[:text_area])
    all_page_text_areas.each do |element|
      element.send_keys('Test Automation')
    end
  end

  def verify_titles_and_questions(entry_type)
    expected_questions = retrieve_expected_structure(entry_type)['titles_and_questions']
    titles_and_questions_arr = []
    find_elements('//h4').each do |field|
      titles_and_questions_arr << field.text
    end
    raise 'title and questions verify failed' unless titles_and_questions_arr == expected_questions
  end

  def verify_titles_of_sections(entry_type)
    expected_title = retrieve_expected_structure(entry_type)['titles_of_sections']
    titles_of_sections = []
    find_elements('//h2').each do |field|
      titles_of_sections << field.text
    end
    raise 'title of section verify failed' unless titles_of_sections == expected_title
  end

  def verify_answers_of_sections_one(entry_type)
    expected_section_one = retrieve_expected_structure(entry_type)['answer_first_section']
    answers = []
    find_elements('//span').each do |field|
      answers << field.text
    end
    raise 'section one verify failed' unless answers == expected_section_one
  end

  def verify_answers_of_entry_titles(entry_type)
    expected_section_two = retrieve_expected_structure(entry_type)['entry_titles']
    answers_for_sections = retrieve_answers_for_sections
    raise 'entry titles verify failed' unless answers_for_sections == expected_section_two
  end

  def verify_cre_section_title(text)
    raise 'Compressor room header verification failed' unless find_element(COMPRESSOR_ROOM[:cre_header]).text == text
  end

  def verify_gas_added_by(text)
    gas_added_by_actual = @driver.find_element(:css, COMPRESSOR_ROOM[:gas_added_by]).text
    raise 'Gas added by title verification failed' unless gas_added_by_actual == text
  end

  def verify_permit_not_in_list
    permit_number_actual = @driver.find_element(:css, COMPRESSOR_ROOM[:ptw_id]).text
    raise "Permit #{permit_id} is present in list" unless permit_number_actual.eql?(permit_id) == false
  end

  def select_location_of_vessel(loc_type)
    xpath_str = format(COMPRESSOR_ROOM[:location_question], 'Location of vessel')
    xpath_str2 = format(COMPRESSOR_ROOM[:loc_radio_button], loc_type)
    click((xpath_str + xpath_str2).to_s)
  end

  def select_all_checkboxes(answer)
    all_page_radiobutton = find_elements(format(COMPRESSOR_ROOM[:radio_button], answer))
    all_page_radiobutton.each(&:click)
  end

  def verify_non_editable
    verify_element_not_exist(COMPRESSOR_ROOM[:text_area])
    verify_element_not_exist(COMPRESSOR_ROOM[:radio_button])
    verify_element_not_exist(COMPRESSOR_ROOM[:duration_dd_btn])
  end

  def select_permit_duration(duration)
    @driver.execute_script('window.scrollBy(0,document.body.scrollHeight)', '')
    click(COMPRESSOR_ROOM[:duration_dd_btn])
    click(format(COMPRESSOR_ROOM[:dd_list_value], duration))
  end

  def click_terminate_btn
    scroll_click(COMPRESSOR_ROOM[:terminate_btn])
  end

  private

  def retrieve_expected_structure(entry_type)
    if entry_type == 'CRE'
      YAML.load_file('data/cre/cre_forms.yml')['structure_creation']
    else
      YAML.load_file('data/pre/pre_forms.yml')['structure_creation']
    end
  end

  def retrieve_answers_for_sections
    answers_for_section_second = []
    find_elements('//label').each do |field|
      answers_for_section_second << field.text
    end
    answers_for_section_second
  end
end
