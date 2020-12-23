# frozen_string_literal: true

require 'rspec/expectations'

module AssertionUtil
    def is_enabled(element)
      expect(element.enabled?).to be true
    end

    def is_disabled(element)
      expect(element.enabled?).to be false
    end

    def is_equal(compare_to_text, equal_text)
      expect(compare_to_text.to_s).to eql equal_text.to_s
    end

    def is_not_equal(compare_to_text, equal_text)
      expect(compare_to_text.to_s).not_to eql equal_text.to_s
    end

    def is_true(compare_element)
      expect(compare_element).to be true
    end

    def is_false(compare_element)
      expect(compare_element).to be false
    end

    def does_include(compare_to_text, include_text)
      expect(compare_to_text).to include include_text
    end

    def does_not_include(compare_to_text, include_text)
      expect(compare_to_text).not_to include include_text
    end

    def not_to_exists(element)
      expect(element).not_to exist
    end

    def to_exists(element)
      expect(element).to exist
    end

    def poll_exists_and_click(element)
      (expect(element).to exist) ? element.click : poll_exists_and_click(element)
    end

    def is_not_visible(element)
      expect(element).not_to be_visible
    end

    def wait_until_is_visible(element)
      # wait = Selenium::WebDriver::Wait.new(:timeout => 15)
      # wait.until { element.displayed? }
      # expect(element).to be_visible
      sleep 3 until element.exists?
    end

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
end
