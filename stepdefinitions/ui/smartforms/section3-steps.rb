# frozen_string_literal: true

Then (/^I should see section 3a screen$/) do
  is_equal(on(Section2Page).heading_text_element.text, 'Section 3A: DRA - Method & Hazards')
end

When (/^I navigate to section 3a$/) do
  step 'I fill up section 1'
  step 'I proceed to section 3a'
end

Then (/^I should see correct DRA contents$/) do
  on(Section3APage).is_dra_contents
end
