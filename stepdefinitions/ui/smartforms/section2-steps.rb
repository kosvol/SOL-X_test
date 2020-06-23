# frozen_string_literal: true

Then (/^I should see section 2$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 2: Approving Authority')
end
