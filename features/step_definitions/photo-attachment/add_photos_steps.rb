# frozen_string_literal: true

require_relative '../../../page_objects/photo_attachment/add_photos_page'

Then('{string} should see Open Photos button') do |section|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_camera_btn(section)
end

Then('Section8 should see Open Photos button') do |section|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_camera_btn(section)
end

Then('{string} should not see Open Photos button') do |section|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_no_camera_btn(section)
end

And('PhotoAttachment click Open Photos button') do
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.click_open_photo_btn
end

And('PhotoAttachment click Capture Photo button') do
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.click_capture_photo_btn
end

And('PhotoAttachment click Add Photo button') do
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.click_add_photo_btn
end

And('PhotoAttachment verify photo thumbnail is {string}') do |photo_num|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_photo_num(photo_num)
end

Then('PhotoAttachment verify {string} photo limit warning before approval') do |photo_num|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_bfr_photo_limit_warning(photo_num)
end

Then('PhotoAttachment verify {string} photo limit warning after approval') do |photo_num|
  @add_photos_page ||= PhotoAttachmentPage.new(@driver)
  @add_photos_page.verify_aft_photo_limit_warning(photo_num)
end

And('PhotoAttachment verify Capture Photo button is {string}') do |option|
  @add_photos_page.verify_capture_photo_btn(option)
end
