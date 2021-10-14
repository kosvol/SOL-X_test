# frozen_string_literal: true

# class to retrieve maps
# To add new permit type, you need to add section0 and section4 checklist json to folder
# Also add checklist map here
class PermitMap
  PERMIT_MAP = {
    enclosed_spaces_entry: 'enclosed_spaces_entry',
    use_safe_camera: 'use_safe_camera',
    hot_work_designated: 'hot_work_designated',
    cre: 'cre',
    pre: 'pre'
  }.freeze

  CHECKLIST_MAP = {
    enclosed_spaces_entry: 'openChecklistEnclosedSpaceEntry',
    use_safe_camera: 'openChecklistUseOfCamera',
    hot_work_designated: 'openChecklistHotWorkWithinDesignatedArea'
  }.freeze

  APPROVE_MAP = {
    enclosed_spaces_entry: 'PENDING_MASTER_APPROVAL',
    use_safe_camera: 'PENDING_OFFICE_APPROVAL',
    hot_work_designated: 'PENDING_MASTER_APPROVAL',
    pre: 'PENDING_OFFICER_APPROVAL',
    cre: 'PENDING_OFFICER_APPROVAL'
  }.freeze

  def retrieve_permit_type(permit_type_plain)
    PERMIT_MAP[permit_type_plain.to_sym]
  end

  def retrieve_checklist_string(permit_type)
    CHECKLIST_MAP[permit_type.to_sym]
  end

  def retrieve_approve_type(permit_type)
    APPROVE_MAP[permit_type.to_sym]
  end
end
