# frozen_string_literal: true


require_relative '../base_page'
require_relative 'create_entry_permit_page'

# CompressorRoomPage object
class CompressorRoomPage < CreateEntryPermitPage
  include EnvUtils
  COMPRESSOR_ROOM = {
    cre_scrap: "//div/*/*[local-name()='span' or local-name()='label']",
    compressor_room_display_setting: "//span[contains(.,'Compressor/Motor Room')]"
  }.freeze

end
