# frozen_string_literal: true

require_relative '../../../../page_objects/sections/checklist_page'

Given('Checklist verify checklist questions {string}') do |checklist|
  @checklist_page = ChecklistPage.new(@driver)
  @checklist_page.verify_checklist_questions(checklist)
end

Given('Checklist verify checklist box') do |table|
  @checklist_page = ChecklistPage.new(@driver)
  parms = table.hashes.first
  @checklist_page.verify_checklist_box(parms['checklist'], parms['box_type'])
end

Given('Checklist should see location stamp {string}') do |zone|
  @checklist_page = ChecklistPage.new(@driver)
  @checklist_page.verify_location_stamp(zone)
end

Given('Checklist verify signature rank {string}') do |rank|
  @checklist_page = ChecklistPage.new(@driver)
  @checklist_page.verify_rank_name(rank)
end

Given('Checklist verify checklist answer') do
  @checklist_page = ChecklistPage.new(@driver)
  @checklist_page.verify_checklist_answers
end
