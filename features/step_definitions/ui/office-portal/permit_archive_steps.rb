# frozen_string_literal: true

require_relative '../../../../page_objects/office_portal/permit_archive_page'

Then('PermitArchive page should be displayed') do
  @permit_archive ||= OPPermitArchivePage.new(@driver)
  @permit_archive.verify_permit_archive_item
end