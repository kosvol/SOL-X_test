# frozen_string_literal: true

require_relative '../../../page_objects/geofence_page'

And('GeoFence click cancel') do
  @geofence_page ||= GeoFencePage.new(@driver)
  @geofence_page.click_cancel_btn
end
