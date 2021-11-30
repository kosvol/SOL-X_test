# frozen_string_literal: true


require_relative '../base_page'
require_relative 'create_entry_permit_page'

# CompressorRoomPage object
class CompressorRoomPage < CreateEntryPermitPage
  include EnvUtils
  COMPRESSOR_ROOM = {
    cre_scrap: "//div/*/*[local-name()='span' or local-name()='label']",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]",
    button_sample: "//span[contains(.,'%s')]",
    text_area: '//textarea'
  }.freeze

  def fill_cre_form(duration)
    tmp_elements = find_elements(COMPRESSOR_ROOM[:text_area])
    tmp_elements.each do |element|
      element.send_keys('Test Automation')
    end
    click(format(COMPRESSOR_ROOM[:button_sample], ['At Sea', 'In Port'].sample).to_s)
    select_permit_duration(duration)
  end

end
