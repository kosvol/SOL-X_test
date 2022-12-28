# frozen_string_literal: true

require_relative '../base_page'

# AddPhotosPage object
class PhotoAttachmentPage < BasePage
  PHOTO_ATTACHMENTS = {
    open_photo_btn: "//button[contains(@class,'OpenPhotosButton')]",
    capture_photo_btn: "//button[contains(@class,'Camera__CapturePhotoButton')]",
    add_photo_btn: "//button[span='Add this photo']",
    photos_attached_num: "//div[contains(@class, 'Camera__Thumbnail')]/div",
    photo_limit_warning: "//div[contains(@class, 'CameraError__ErrorContainer')]/p"
  }.freeze

  LESS_THAN_THREE_PHOTOS_NOTE = 'Please take max. 3 photos before sending for approval and max.' \
                                ' 3 photos before Permit withdrawal'
  BFR_APVL_PHOTOS_LIMIT_NOTE = 'You have reached the max. limit of 3 photos before sending for approval'
  AFT_APVL_PHOTOS_LIMIT_NOTE = 'You have reached the max. limit of 3 photos before sending for Permit withdrawal'

  def verify_camera_btn(section)
    find_element(PHOTO_ATTACHMENTS[:open_photo_btn] % section)
  end

  def verify_no_camera_btn(section)
    verify_element_not_exist(PHOTO_ATTACHMENTS[:open_photo_btn] % section)
  end

  def click_open_photo_btn
    click(PHOTO_ATTACHMENTS[:open_photo_btn])
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

  def verify_photo_num(photo_num)
    photo_num == find_element(PHOTO_ATTACHMENTS[:photos_attached_num])
  end

  def verify_bfr_photo_limit_warning(photo_num)
    if photo_num == '3'
      compare_string(BFR_APVL_PHOTOS_LIMIT_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    else
      compare_string(LESS_THAN_THREE_PHOTOS_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    end
  end

  def verify_aft_photo_limit_warning(photo_num)
    if photo_num == '3'
      compare_string(AFT_APVL_PHOTOS_LIMIT_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    else
      compare_string(LESS_THAN_THREE_PHOTOS_NOTE, retrieve_text(PHOTO_ATTACHMENTS[:photo_limit_warning]))
    end
  end
end