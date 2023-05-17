# frozen_string_literal: true

require_relative '../../../page_objects/photo_attachment/photo_attachment_page'

Given('PhotoAttachment should see section header') do
  @section_two_page ||= PhotoAttachmentPage.new(@driver)
end

And('PhotoAttachment click Capture Photo button') do
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.click_capture_photo_btn
end

And('PhotoAttachment click Add Photo button') do
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.click_add_photo_btn
end

And('PhotoAttachment verify photo count {string}') do |count|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_photo_count(count)
end

Then('PhotoAttachment verify {string} photo limit warning before approval') do |count|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_bfr_photo_limit_warning(count)
end

Then('PhotoAttachment verify {string} photo limit warning after approval') do |count|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_aft_photo_limit_warning(count)
end

And('PhotoAttachment verify Capture Photo button is {string}') do |option|
  @add_photos_page.verify_capture_photo_btn(option)
end
