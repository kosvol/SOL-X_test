# frozen_string_literal: true

require_relative '../../../page_objects/photo_attachment/photo_attachment_page'

And('PhotoAttachment click Capture Photo button') do
  @photo_attachment_page ||= PhotoAttachmentPage.new(@driver)
  @photo_attachment_page.click_capture_photo_btn
end

And('PhotoAttachment click Add Photo button') do
  @photo_attachment_page ||= PhotoAttachmentPage.new(@driver)
  @photo_attachment_page.click_add_photo_btn
end

And('PhotoAttachment verify photo count {string}') do |count|
  @photo_attachment_page ||= PhotoAttachmentPage.new(@driver)
  @photo_attachment_page.verify_photo_count(count)
end

Then('PhotoAttachment verify {int} photo limit warning {string} approval') do |count, state|
  @photo_attachment_page ||= PhotoAttachmentPage.new(@driver)
  @photo_attachment_page.verify_photo_limit_warning(count, state)
end

And('PhotoAttachment verify Capture Photo button is {string}') do |option|
  @photo_attachment_page.verify_capture_photo_btn(option)
end

And('PhotoAttachment sleep for {string} sec') do |sec|
  sleep sec.to_i
end
