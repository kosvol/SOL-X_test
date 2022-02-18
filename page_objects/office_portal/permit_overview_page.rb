# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/api/couch_db_api'

#OPPermitOverviewPage objects
class OPPermitOverviewPage < BasePage
  include EnvUtils

  PERMIT_OVERVIEW = {
    permit_section1_header: "//div[@class='screen-only']//h2[contains(text(),'Section 1')]",
    section_fields: "//div[@class='screen-only']//h2[contains(text(),'%s')]/../..//h4",
    section_labels: "//div[@class='screen-only']//h2[contains(text(),'%s')]/../..//label",
    section_headers: "//div[@class='screen-only']//h2[contains(text(),'%s')]/../..//h2",
    eic_fields: "(//div[@class='screen-only']//h2[contains(text(),'Energy Isolation Certificate')])[2]/../..//h4",
    eic_labels: "(//div[@class='screen-only']//h2[contains(text(),'Energy Isolation Certificate')])[2]/../..//label",
    eic_headers: "(//div[@class='screen-only']//h2[contains(text(),'Energy Isolation Certificate')])[2]/../..//h2"
  }.freeze

  def open_overview_page(permit_id)
    @driver.get(format("#{generate_base_url}/permit-overview?formId=%s", permit_id))
    p permit_id
    section_header = PERMIT_OVERVIEW[:permit_section1_header]
    wait_for_copy_display(section_header)
  end

  def wait_for_copy_display(xpath)
    wait = 0
    element = find_element(xpath)
    until element.displayed?
      sleep 2
      wait += 1
      raise 'time out waiting for copy display' if wait > 10
    end
  end

  def check_section_fields(what_section, eic_condition, gas_reading_condition)
    p "> #{eic_condition}"
    p "> #{gas_reading_condition}"
    fields_arr = retrieve_actual_fields_list(what_section)
    base_fields = retrieve_base_fields_list(what_section, eic_condition, gas_reading_condition)
    p "> #{fields_arr}"
    p ">> #{base_fields}"
    p ">>> difference #{fields_arr - base_fields}"
    compare_string(base_fields, fields_arr)
  end

  def check_section_labels(what_section)
    labels_arr = retrieve_actual_labels_list(what_section)
    base_labels = retrieve_base_labels_list(what_section)
    p "> #{labels_arr}"
    p ">> #{base_labels}"
    p ">>> difference #{labels_arr - base_labels}"
    compare_string(base_labels, labels_arr)
  end

  def check_section_headers(what_section, permit_id)
    headers_arr = retrieve_actual_headers_list(what_section)
    base_headers = retrieve_base_headers_list(what_section, permit_id)
    p "> #{headers_arr}"
    p ">> #{base_headers}"
    p ">>> difference #{headers_arr - base_headers}"
    compare_string(base_headers, headers_arr)
  end

  def check_checklist_questions(checklist)
    actual_questions_arr = questions?(checklist)
    base_data = ['Vessel Name:', 'Created On:']
    base_data += (YAML.load_file("data/checklist/#{checklist}.yml")['questions'] - YAML
                 .load_file('data/checklist/checklist_exceptions.yml')['exceptions'])
    p "> difference #{actual_questions_arr - base_data}"
    compare_string(actual_questions_arr, base_data)
  end

  private

  def retrieve_actual_fields_list(section)
    fields_arr = []
    elements = if section == 'Energy Isolation Certificate'
                 PERMIT_OVERVIEW[:eic_fields]
               else
                 format(PERMIT_OVERVIEW[:section_fields], section)
               end
    find_elements(elements).each do |field|
      fields_arr << field.text
    end
    fields_arr -= YAML.load_file("data/screens-label/#{section}.yml")['fields_exceptions']
    fields_arr
  end

  def retrieve_base_fields_list(section, eic_condition, gas_reading_condition)
    case section
    when 'Section 4B'
      [] + YAML.load_file("data/screens-label/#{section}.yml")["fields_eic_#{eic_condition}"]
    when 'Section 8'
      [] + YAML.load_file("data/screens-label/#{section}.yml")["fields_eic_#{eic_condition}"]
    when 'Section 6'
      [] + YAML.load_file("data/screens-label/#{section}.yml")["fields_eic_#{gas_reading_condition}"]
    else
      [] + YAML.load_file("data/screens-label/#{section}.yml")['fields']
    end
      #[] + YAML.load_file("data/screens-label/#{section}.yml")['fields']
    #if @permit_type == 'submit_maintenance_on_anchor'
    #            [] + YAML.load_file("data/screens-label/#{what_section}.yml")['fields_maintenance']
    #          else
    #            [] + YAML.load_file("data/screens-label/#{what_section}.yml")['fields']
    #          end
  end

  def retrieve_actual_labels_list(section)
    labels_arr = []
    elements = if section == 'Energy Isolation Certificate'
                 PERMIT_OVERVIEW[:eic_labels]
               else
                 format(PERMIT_OVERVIEW[:section_labels], section)
               end
    find_elements(elements).each do |label|
      labels_arr << label.text
    end
    labels_arr -= YAML.load_file("data/screens-label/#{section}.yml")['labels_exceptions']
    labels_arr
  end

  def retrieve_base_labels_list(section)
    [] + YAML.load_file("data/screens-label/#{section}.yml")['labels']
  end

  def retrieve_actual_headers_list(section)
    headers_arr = []
    elements = if section == 'Energy Isolation Certificate'
                 PERMIT_OVERVIEW[:eic_headers]
               else
                 format(PERMIT_OVERVIEW[:section_headers], section)
               end
    find_elements(elements).each do |header|
      headers_arr << header.text
    end
    headers_arr -= YAML.load_file("data/screens-label/#{section}.yml")['subheaders_exceptions']
    headers_arr
  end

  def retrieve_base_headers_list(what_section, permit_id)
    if (permit_id.include? 'FSU') && what_section == 'Energy Isolation Certificate'
      [] + YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders_fsu']
    else
      [] + YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders']
    end
  end

  def questions?(checklist)
    questions_arr = []
    case checklist
    when 'Work on Pressure Pipelines'
      find_elements("//div[@class='screen-only']//h2[contains(text(),'Work on Pressure Pipeline/Pressure Vessels')]/../..//h4")
        .each do |question|
        questions_arr << question.text
      end
    when 'Working Aloft Overside'
      find_elements("//div[@class='screen-only']//h2[contains(text(),'Working Aloft/Overside')]/../..//h4")
        .each do |question|
        questions_arr << question.text
      end
    else
      find_elements("//div[@class='screen-only']//h2[contains(text(),'#{checklist}')]/../..//h4")
        .each do |question|
        questions_arr << question.text
      end
    end
    questions_arr
  end
end
