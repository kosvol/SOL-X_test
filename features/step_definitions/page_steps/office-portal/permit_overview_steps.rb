# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/op_permit_overview_page'

And('PermitOverview follow the permit link') do
  @permit_overview ||= OPPermitOverviewPage.new(@driver)
  @permit_overview.open_overview_page(@permit_id)
end

And('PermitOverview verify section') do |table|
  params = table.hashes.first
  @permit_overview.check_section_fields(params['section'], params['eic'], params['gas'], params['permit_type'])
  @permit_overview.check_section_labels(params['section'])
  @permit_overview.check_section_headers(params['section'], @permit_id, params['eic'])
end

Then('PermitOverview verify the checklist {string}') do |checklist|
  @permit_overview.check_checklist_questions(checklist)
end

Then('PermitOverview verify {string}') do |entry_type|
  @permit_overview.check_entry_fields(entry_type)
  @permit_overview.check_entry_headers(entry_type)
end