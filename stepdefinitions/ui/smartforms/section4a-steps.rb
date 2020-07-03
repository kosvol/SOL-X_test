# frozen_string_literal: true

Then (/^I should see correct checklist (.+) pre-selected$/) do |_checklist|
  is_true(on(Section4APage).is_checklist_preselected(_checklist))
end

Then (/^I should see Work on Hazardous Substances checklist exists and uncheck$/) do
  is_true(on(Section4APage).is_hazardous_substance_checklist)
end
