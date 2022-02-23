# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/permit_overview_page'

And('PermitOverview follow the permit link') do
  @permit_overview ||= OPPermitOverviewPage.new(@driver)
  @permit_overview.open_overview_page(@permit_id)
end

And('PermitOverview should see the {string} shows the same fields as in the Client app') do |what_section|
  @permit_overview.check_section_fields(what_section, @eic_condition, @gas_reading_condition, @permit_type)
  @permit_overview.check_section_labels(what_section)
  @permit_overview.check_section_headers(what_section, @permit_id, @eic_condition)
end

Then('PermitOverview should see the {string} checklist shows the same fields as in the Client app') do |checklist|
  @permit_overview.check_checklist_questions(checklist)
end