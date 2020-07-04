# frozen_string_literal: true

Then (/^I should see correct checklist (.+) pre-selected$/) do |_checklist|
  is_true(on(Section4APage).is_checklist_preselected(_checklist))
end

Then (/^I should see Work on Hazardous Substances checklist exists and uncheck$/) do
  is_true(on(Section4APage).is_hazardous_substance_checklist)
end

Then (/^I should see correct checklist content for (.+) checklist$/) do |_checklist|
  on(Section4APage).select_checklist(_checklist)
  on(Section4APage).is_checklist_content(_checklist)
end

And (/^I select the matching (.+) checklist$/) do |_checklist|
  on(Section4APage).select_checklist(_checklist)
  step 'I press next for 4 times'
end

And ('I press next for {int} times') do |_times|
  (1.._times).each do |_i|
    sleep 1
    BrowserActions.scroll_down
    on(Section4APage).next_btn
  end
end
