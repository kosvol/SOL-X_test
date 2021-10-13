# frozen_string_literal: true

Then('I should see two additional permits') do
  base_permits = YAML.load_file('data/permit-types.yml')['LNG Critical Equipment Maintenance']
  on(Section0Page).list_permit_type_elements.each_with_index do |element, index|
    is_equal(element.text, base_permits[index])
  end
end
