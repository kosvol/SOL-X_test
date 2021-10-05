# frozen_string_literal: true

# class to retrieve maps
# To add new permit type, you need to add section0 and section4 checklist json to folder
# Also add checklist map here
class PermitMap
  PERMIT_MAP = {
    enclosed_spaces_entry: 'enclosed_spaces_entry',
    use_of_camera: 'use_of_camera',
    hot_work: 'hot_work'
  }.freeze

  CHECKLIST_MAP = {
    enclosed_spaces_entry: 'openChecklistEnclosedSpaceEntry',
    use_safe_camera: 'openChecklistUseOfCamera',
    hot_work: 'openChecklistHotWorkWithinDesignatedArea'
  }.freeze

  def retrieve_permit_type(permit_type_plain)
    PERMIT_MAP[permit_type_plain.to_sym]
  end

  def retrieve_checklist_string(permit_type)
    CHECKLIST_MAP[permit_type.to_sym]
  end
end
