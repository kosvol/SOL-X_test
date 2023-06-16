# frozen_string_literal: true

require_relative '../base_page'

# PhotoAttachmentPage object
class PhotoAttachmentPage < BasePage
  include EnvUtils
  PHOTO_ATTACHMENTS = {
    page_header: "//h1[contains(.,'Take photo')]",
    capture_photo_btn: "//button[contains(@class,'Camera__CapturePhotoButton')]",
    add_photo_btn: "//button[span='Add this photo']",
    photos_attached_count: "//div[contains(@class, 'Camera__Thumbnail')]/div",
    photo_limit_warning: "//div[contains(@class, 'CameraError__ErrorContainer')]/p"
  }.freeze

  LESS_THAN_THREE_PHOTOS_NOTE = 'Please take max. 3 photos before sending for approval and max.' \
                                ' 3 photos before Permit withdrawal'
  BFR_APVL_PHOTOS_LIMIT_NOTE = 'You have reached the max. limit of 3 photos before sending for approval'
  AFT_APVL_PHOTOS_LIMIT_NOTE = 'You have reached the max. limit of 3 photos before sending for Permit withdrawal'

  def initialize(driver)
    super
    find_element(PHOTO_ATTACHMENTS[:page_header])
  end

  def verify_photo_count(count)
    compare_string(count, retrieve_text(PHOTO_ATTACHMENTS[:photos_attached_count]))
  end

  def verify_photo_limit_warning(count, state)
    if count < 3
      compare_string(LESS_THAN_THREE_PHOTOS_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    else
      check_photo_limit_text(state)
    end
  end

  def click_capture_photo_btn
    click(PHOTO_ATTACHMENTS[:capture_photo_btn])
  end

  def verify_capture_photo_btn(option)
    verify_btn_availability(PHOTO_ATTACHMENTS[:capture_photo_btn], option)
  end

  def click_add_photo_btn
    click(PHOTO_ATTACHMENTS[:add_photo_btn])
  end

  private

  def check_photo_limit_text(state)
    case state
    when 'before'
      compare_string(BFR_APVL_PHOTOS_LIMIT_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    when 'after'
      compare_string(AFT_APVL_PHOTOS_LIMIT_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    else
      raise 'Wrong state'
    end
  end
end
