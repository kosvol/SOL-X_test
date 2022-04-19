# frozen_string_literal: true

require_relative '../../../../../page_objects/entry/entry_display/permit_detail_page'

And('PermitDetail wait for latest permit active') do
  @permit_details = PermitDetailPage.new(@driver)
  @permit_details.wait_for_permit_active(@permit_id)
end
