Then ('I should see two additional permits') do
    base_permits = YAML.load_file('data/permits.yml')["LNG Critical Equipment Maintenance"]
    on(Section0Page).list_permit_type_elements.each_with_index do |_element, _index|
    is_equal(_element.text, base_permits[_index])
    end
end