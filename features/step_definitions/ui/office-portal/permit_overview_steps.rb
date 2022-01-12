# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/permit_overview_page'

And('PermitOverview follow the permit link') do
  @permit_overview ||= OPPermitOverviewPage.new(@driver)
  @permit_overview.open_overview_page(@permit_id)
end

Then('PermitOverview should see the final copy') do
  @permit_overview ||= OPPermitOverviewPage.new(@driver)
  @permit_overview.verify_final_copy
end

And('PermitOverview should see the {string} shows the same fields as in the Client app') do |what_section|
  @permit_overview.check_section_fields(what_section)
  @permit_overview.check_section_labels(what_section)
  @permit_overview.check_section_headers(what_section, @permit_id)
end