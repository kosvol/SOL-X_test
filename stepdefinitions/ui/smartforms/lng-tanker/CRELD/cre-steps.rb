Then (/^I should see CRE form questions$/) do
  titles_and_questions_arr = []
  titles_of_sections = []
  answears_for_section = []
  answears_for_section_second = []

  $browser.find_elements(:xpath, '//h4').each do |field|
    titles_and_questions_arr << field.text
  end
  $browser.find_elements(:xpath, '//h2').each do |field|
    titles_of_sections << field.text
  end
  $browser.find_elements(:xpath, '//span').each do |field|
    answears_for_section << field.text
  end
  $browser.find_elements(:xpath, '//label').each do |field|
    answears_for_section_second << field.text
  end
  base_titles_and_questions = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['titles_and_questions']
  base_titles_of_sections = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['titles_of_sections']
  base_answears_first_section = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['answears_first_section']
  base_entry_titles = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['entry_titles']
  base_gas_section = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['gas_section']
  base_permit_validity = [] + YAML.load_file('data/cre/cre-forms.yml')['cre_structure_creation']['permit_validity']
  is_equal(titles_and_questions_arr, base_titles_and_questions)
  is_equal(titles_of_sections, base_titles_of_sections)
  is_true((answears_for_section & base_answears_first_section).any? { |x| base_answears_first_section.include?(x) })
  is_true((answears_for_section_second & base_entry_titles) == base_entry_titles)
  is_true((answears_for_section_second & base_gas_section) == base_gas_section)
  is_true((answears_for_section_second & base_permit_validity).any? { |x| base_permit_validity.include?(x) })
end

Then (/^I (should|should not) see CRE landing screen$/) do |_condition|
  if _condition === 'should'
    is_true(on(PumpRoomEntry).heading_text == 'Compressor/Motor Room Entry')
  end
end
