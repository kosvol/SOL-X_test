# frozen_string_literal: true

require 'rspec/expectations'

module AssertionUtil
  # def is_textfield_length(element, acceptable_length)
  #   element.text.length > acceptable_length ? (return false) : (return true)
  # end

  # def is_selected?(element)
  #   element.selected?
  # end

  def is_enabled?(element)
    element.enabled?
  end

  # def is_display(element)
  #   begin
  #     element.displayed?
  #   rescue
  #     return false
  #   end
  # end

  def is_equal(compare_to_text, equal_text)
    expect(compare_to_text.to_s).to eql equal_text.to_s
  end

  def is_not_equal(compare_to_text, equal_text)
    expect(compare_to_text.to_s).not_to eql equal_text.to_s
  end

  def is_true(compare_element)
    expect(compare_element).to be true
  end

  def does_include(compare_to_text, include_text)
    expect(compare_to_text).to include include_text
  end

  def does_not_include(compare_to_text, include_text)
    expect(compare_to_text).not_to include include_text
  end

  # # def not_to_exists(element)
  # #   expect(element).not_to exist
  # # end

  # def is_not_visible(element)
  #   expect(element).not_to be_visible
  # end

  # def is_visible(element)
  #   expect(element).to be_visible
  # end

  # def select_from_dropdown(dropdown_list,which_type)
  #   wait_for_element(dropdown_list)
  #   dropdown_list.list_items.each do |type|
  #     if type.text == which_type
  #       type.click
  #       break
  #     end
  #   end
  # end

  # def select_from_dropdown_with_inclusion(dropdown_list,which_type)
  #   wait_for_element(dropdown_list)
  #   dropdown_list.list_items.each do |type|
  #     if type.text.include? which_type
  #       type.click
  #       break
  #     end
  #   end
  # end
end
