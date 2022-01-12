# frozen_string_literal: true

require_relative '../base_page'
require_relative '../../service/api/couch_db_api'

#OPPermitOverviewPage objects
class OPPermitOverviewPage < BasePage
  include EnvUtils

  PERMIT_OVERVIEW = {
    permit_section1_header: "//div[@class='screen-only']//h2[contains(text(),'Section 1')]",
    email_field: "//input[@id='email']",
    section_fields: "(//h2[contains(text(),'%<section>s')])[%<index>s]/../..//h4",
    section_labels: "(//h2[contains(text(),'%<section>s')])[%<index>s]/../..//label",
    section_headers: "(//h2[contains(text(),'%<section>s')])[%<index>s]/../..//h2"
  }.freeze

  def open_overview_page(permit_id)
    @driver.get(format("#{generate_base_url}/permit-overview?formId=%s", permit_id))
    p permit_id
    find_element(PERMIT_OVERVIEW[:email_field])
  end

  def verify_final_copy
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

  def check_section_fields(what_section, eic_condition = nil, gas_reading_condition = nil)
    fields_arr = retrieve_actual_fields_list(what_section)
    base_fields = retrieve_base_fields_list(what_section)
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

    base_headers = if permit_id.include? 'FSU'
                     [] + YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders_fsu']
                   else
                     [] + YAML.load_file("data/screens-label/#{what_section}.yml")['subheaders']
                   end

    p "> #{headers_arr}"
    p ">> #{base_headers}"
    p "> difference #{headers_arr - base_headers}"
    compare_string(base_headers, headers_arr)
  end

  private

  def retrieve_actual_fields_list(section)
    fields_arr = []
    elements = if section == 'Energy Isolation Certificate'
                 format(PERMIT_OVERVIEW[:section_fields], section: section, index: 5)
               else
                 format(PERMIT_OVERVIEW[:section_fields], section: section, index: 2)
               end
    find_elements(elements).each do |field|
      fields_arr << field.text
    end
    fields_arr -= YAML.load_file("data/screens-label/#{section}.yml")['fields_exceptions']
    fields_arr
  end

  def retrieve_base_fields_list(section)
    #base_fields =
    [] + YAML.load_file("data/screens-label/#{section}.yml")['fields']
    #if @permit_type == 'submit_maintenance_on_anchor'
    #            [] + YAML.load_file("data/screens-label/#{what_section}.yml")['fields_maintenance']
    #          else
    #            [] + YAML.load_file("data/screens-label/#{what_section}.yml")['fields']
    #          end
    #base_fields
  end

  def retrieve_actual_labels_list(section)
    labels_arr = []
    elements = if section == 'Energy Isolation Certificate'
                 format(PERMIT_OVERVIEW[:section_labels], section: section, index: 5)
               else
                 format(PERMIT_OVERVIEW[:section_labels], section: section, index: 2)
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
                 format(PERMIT_OVERVIEW[:section_headers], section: section, index: 5)
               else
                 format(PERMIT_OVERVIEW[:section_headers], section: section, index: 2)
               end
    find_elements(elements).each do |header|
      headers_arr << header.text
    end
    headers_arr -= YAML.load_file("data/screens-label/#{section}.yml")['subheaders_exceptions']
    headers_arr
  end
end
