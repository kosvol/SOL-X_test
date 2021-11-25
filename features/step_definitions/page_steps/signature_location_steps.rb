# frozen_string_literal: true

require_relative '../../../page_objects/signature_location_page'

Given('SignatureLocation should see zone as {string}') do |zone|
  @signature_page ||= SignatureLocationPage.new(@driver)
  @signature_page.verify_default_zone_selected(zone)
end

And('SignatureLocation click location dropdown') do
  @signature_page ||= SignatureLocationPage.new(@driver)
  @signature_page.click_location_dropdown
end

And('SignatureLocation select area {string}') do |area|
  @signature_page ||= SignatureLocationPage.new(@driver)
  @signature_page.select_zone(area)
end

And('SignatureLocation select zone {string}') do |zone|
  @signature_page.select_zone(zone)
end

And('SignatureLocation sign off') do |table|
  params = table.hashes.first
  @signature_page ||= SignatureLocationPage.new(@driver)
  @signature_page.sign_off(params['area'], params['zone'])
end

And('SignatureLocation sign off first zone area') do
  @signature_page ||= SignatureLocationPage.new(@driver)
  @signature_page.sign_off_first_zone_area
end
