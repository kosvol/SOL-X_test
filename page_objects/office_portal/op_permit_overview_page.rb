# frozen_string_literal: true

require_relative '../base_page'

# OPPermitOverviewPage objects
class OPPermitOverviewPage < BasePage
  include EnvUtils

  PERMIT_OVERVIEW = {
    nav_bar: '//h1',
    permit_withdrawn_header: "//div[@class='screen-only']//h2[contains(text(),'Permit Withdrawn')]",
    permit_pre_cre_header: "//div[@class='screen-only']//h2[contains(text(),'Entry Permit')]",
    rol_headers: "//div[@class='screen-only']//div[contains(@class,'Section__Description')]//h2",
    rol_subheaders: "//div[@class='screen-only']//div[contains(@class,'Section__Description')]//h4",
    rol_other:
     "//div[@class='screen-only']//div[contains(@class,'Section__Description')]//label[contains(@for, 'bestPractice')]",
    section_fields: "//div[@class='screen-only']//h2[contains(text(),'%s')]/../..//h4",
    section_labels: "//div[@class='screen-only']//h2[contains(text(),'%s')]/../..//label",
    section_subheaders: "//div[@class='screen-only']//h2[contains(text(),'%s')]/../..//h2",
    pre_cre_fields: "//div[@class='screen-only']//h2[contains(text(),'Entry Permit')]/../..//h4",
    pre_cre_subheaders: "//div[@class='screen-only']//h2[contains(text(),'Entry Permit')]/../..//h2",
    eic_fields: "(//div[@class='screen-only']//h2[contains(text(),'Energy Isolation Certificate')])[2]/../..//h4",
    eic_labels: "(//div[@class='screen-only']//h2[contains(text(),'Energy Isolation Certificate')])[2]/../..//label",
    eic_subheaders: "(//div[@class='screen-only']//h2[contains(text(),'Energy Isolation Certificate')])[2]/../..//h2"
  }.freeze

  SECTION_MAP = {
    'Section 1': 'section_1',
    'Section 2': 'section_2',
    'Section 3A': 'section_3A',
    'Section 3B': 'section_3B',
    'Section 3C': 'section_3C',
    'Section 3D': 'section_3D',
    'Section 4A': 'section_4A',
    'Section 4B': 'section_4B',
    'Energy Isolation Certificate': 'energy_isolation_certificate',
    'Section 5': 'section_5',
    'Section 6': 'section_6',
    'Section 7': 'section_7',
    'Section 7B': 'section_7B',
    'Section 8': 'section_8',
    'Section 9': 'section_9',
    'CRE': 'cre',
    'PRE': 'pre'
  }.freeze

  def open_overview_page(permit_id)
    @driver.get(format("#{generate_base_url}/permit-overview?formId=%s", permit_id))
    section_header = if permit_id.include? 'PTW'
                       PERMIT_OVERVIEW[:permit_withdrawn_header]
                     else
                       PERMIT_OVERVIEW[:permit_pre_cre_header]
                     end
    wait_for_copy_display
  end

  def wait_for_copy_display
    sleep 0.5
    wait = 0
    while find_element(PERMIT_OVERVIEW[:nav_bar]).text == 'Loading...'
      @logger.debug "wait for loading screen, retrying: #{wait} times"
      sleep 0.5
      wait += 1
      raise 'time out waiting for loading screen' if wait > 30
    end
  end

  def check_section_fields(what_section, eic_condition, gas_reading_cond, permit_type)
    fields_arr = retrieve_actual_elements_list(what_section, 'fields')
    base_fields = case what_section
                  when 'Section 1'
                    section1_base_fields_by_type(permit_type)
                  when 'Section 8'
                    section8_base_fields_with_cond(eic_condition, permit_type)
                  else
                    retrieve_base_fields_list(what_section, eic_condition, gas_reading_cond)
                  end
    compare_string(base_fields, fields_arr)
  end

  def check_entry_fields(entry_type)
    fields_arr = retrieve_actual_elements_list(entry_type, 'fields')
    base_fields = retrieve_base_entry_fields(entry_type)
    compare_string(base_fields, fields_arr)
  end

  def check_section_labels(what_section)
    labels_arr = retrieve_actual_elements_list(what_section, 'labels')
    base_labels = retrieve_base_labels_list(what_section)
    compare_string(base_labels, labels_arr)
  end

  def check_section_headers(what_section, permit_id, eic_condition)
    headers_arr = retrieve_actual_elements_list(what_section, 'subheaders')
    base_headers = if what_section == 'Section 8'
                     section8_base_headers_by_type(permit_id, eic_condition)
                   else
                     retrieve_base_headers_list(what_section, permit_id, eic_condition)
                   end
    compare_string(base_headers, headers_arr)
  end

  def check_entry_headers(entry_type)
    headers_arr = retrieve_actual_elements_list(entry_type, 'subheaders')
    base_headers = retrieve_base_entry_headers(entry_type)
    compare_string(base_headers, headers_arr)
  end

  def check_checklist_questions(checklist)
    actual_questions_arr = questions(checklist)
    base_data = ['Vessel Name:', 'Created On:']
    base_data += (YAML.load_file("data/checklist/#{checklist}.yml")['questions'] - YAML
                 .load_file('data/checklist/checklist_exceptions.yml')['exceptions'])
    compare_string(base_data, actual_questions_arr)
  end

  def verify_rol_section_data(section)
    expected_data = retrieve_expected_data(section)
    expected_data.each do |question|
      next if retrieve_rol_section_items('rol_headers').include? question
      next if retrieve_rol_section_items('rol_subheaders').include? question
      next if retrieve_rol_section_items('rol_other').include? question

      raise "Verification failed for the question: '#{question}'"
    end
  end

  private

  def retrieve_actual_elements_list(section, elements_type)
    transformer = SECTION_MAP[section.to_sym]
    elements = select_section_elements(section, elements_type)
    create_elements_array(elements) - YAML
                                      .load_file("data/sections-data/#{transformer}.yml")["#{elements_type}_exceptions"]
  end

  def retrieve_base_fields_list(section, eic_condition, gas_reading_cond)
    transformer = SECTION_MAP[section.to_sym]
    case section
    when 'Section 4B'
      [] + YAML.load_file("data/sections-data/#{transformer}.yml")["fields_eic_#{eic_condition}"]
    when 'Section 6'
      [] + YAML.load_file("data/sections-data/#{transformer}.yml")["fields_gas_#{gas_reading_cond}"]
    else
      [] + YAML.load_file("data/sections-data/#{transformer}.yml")['fields']
    end
  end

  def retrieve_base_entry_fields(entry_type)
    transformer = SECTION_MAP[entry_type.to_sym]
    [] + YAML.load_file("data/sections-data/#{transformer}.yml")['fields']
  end

  def section1_base_fields_by_type(permit_type)
    if permit_type == 'main_anchor'
      [] + YAML.load_file('data/sections-data/section_1.yml')['fields_maintenance']
    else
      [] + YAML.load_file('data/sections-data/section_1.yml')['fields']
    end
  end

  def section8_base_fields_with_cond(eic_condition, permit_type)
    case permit_type
    when 'main_anchor'
      [] + YAML.load_file('data/sections-data/section_8.yml')['fields_critical']
    when 'ele_equip_circuit'
      [] + YAML.load_file('data/sections-data/section_8.yml')['fields_electrical']
    when 'pressure_pipe_vessel'
      [] + YAML.load_file('data/sections-data/section_8.yml')['fields_pipe']
    else
      [] + YAML.load_file('data/sections-data/section_8.yml')["fields_eic_#{eic_condition}"]
    end
  end

  def retrieve_base_labels_list(section)
    transformer = SECTION_MAP[section.to_sym]
    [] + YAML.load_file("data/sections-data/#{transformer}.yml")['labels']
  end

  def retrieve_base_headers_list(section, permit_id, eic_condition)
    transformer = SECTION_MAP[section.to_sym]
    case section
    when 'Energy Isolation Certificate'
      [] + YAML.load_file("data/sections-data/#{transformer}.yml")['subheaders_fsu'] if permit_id.include? 'FSU'
    when 'Section 4B'
      [] + YAML.load_file("data/sections-data/#{transformer}.yml")["subheaders_eic_#{eic_condition}"]
    else
      [] + YAML.load_file("data/sections-data/#{transformer}.yml")['subheaders']
    end
  end

  def section8_base_headers_by_type(permit_id, eic_condition)
    if permit_id.include? 'FSU'
      [] + YAML.load_file('data/sections-data/section_8.yml')["subheaders_eic_#{eic_condition}_fsu"]
    else
      [] + YAML.load_file('data/sections-data/section_8.yml')["subheaders_eic_#{eic_condition}"]
    end
  end

  def retrieve_base_entry_headers(entry_type)
    transformer = SECTION_MAP[entry_type.to_sym]
    [] + YAML.load_file("data/sections-data/#{transformer}.yml")['subheaders']
  end

  def select_section_elements(section, elements_type)
    case section
    when 'Energy Isolation Certificate'
      PERMIT_OVERVIEW["eic_#{elements_type}".to_sym]
    when 'CRE'
      PERMIT_OVERVIEW["pre_cre_#{elements_type}".to_sym]
    when 'PRE'
      PERMIT_OVERVIEW["pre_cre_#{elements_type}".to_sym]
    else
      format(PERMIT_OVERVIEW["section_#{elements_type}".to_sym], section)
    end
  end

  def create_elements_array(elements)
    elements_arr = []
    if @driver.find_elements(xpath: elements).size.positive?
      find_elements(elements).each do |element|
        elements_arr << element.text
      end
    else
      Log.instance.info "#{elements} elements do not exist"
    end
    elements_arr
  end

  def questions(checklist)
    questions_arr = []
    checklist = 'Work on Pressure Pipeline/Pressure Vessels' if checklist == 'Work on Pressure Pipelines'
    checklist = 'Working Aloft/Overside' if checklist == 'Working Aloft Overside'
    find_elements("//div[@class='screen-only']//h2[contains(text(),'#{checklist}')]/../..//h4")
      .each do |question|
      questions_arr << question.text
    end
    questions_arr
  end

  def retrieve_expected_data(section)
    [] + YAML.load_file("data/sections-data/rol_#{section}.yml")['questions'] -
      YAML.load_file("data/sections-data/rol_#{section}.yml")['exceptions'] +
      YAML.load_file("data/sections-data/rol_#{section}.yml")['additions']
  end

  def retrieve_rol_section_items(items)
    questions = []
    elements = @driver.find_elements(:xpath, PERMIT_OVERVIEW[:"#{items.to_sym}"])
    elements.each do |element|
      questions << element.text
    end
    questions
  end
end
