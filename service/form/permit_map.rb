# frozen_string_literal: true

# class to retrieve maps
# To add new permit type, you need to add section0 and section4 checklist json to folder
# Also add checklist map here
class PermitMap
  PERMIT_MAP = {
    enclosed_spaces_entry: 'enclosed_spaces_entry',
    use_safe_camera: 'use_safe_camera',
    hot_work_designated: 'hot_work_designated',
    lifting_operation: 'lifting_operation',
    pressure_pipe_vessel: 'pressure_pipe_vessel',
    main_anchor: 'main_anchor',
    ele_equip_circuit: 'ele_equip_circuit',
    cre: 'cre',
    pre: 'pre'
  }.freeze

  CHECKLIST_MAP = {
    enclosed_spaces_entry: 'openChecklistEnclosedSpaceEntry',
    use_safe_camera: 'openChecklistUseOfCamera',
    hot_work_designated: 'openChecklistHotWorkWithinDesignatedArea',
    lifting_operation: 'openChecklistLiftingOperation',
    pressure_pipe_vessel: 'openChecklistPressurePipelines',
    ele_equip_circuit: 'openChecklistElectricalEquipmentAndCircuit',
    main_anchor: 'openChecklistCriticalEquipMaintenance'

  }.freeze

  APPROVE_MAP = {
    enclosed_spaces_entry: 'PENDING_MASTER_APPROVAL',
    use_safe_camera: 'PENDING_OFFICE_APPROVAL',
    hot_work_designated: 'PENDING_MASTER_APPROVAL',
    pre: 'PENDING_OFFICER_APPROVAL',
    cre: 'PENDING_OFFICER_APPROVAL',
    lifting_operation: 'PENDING_MASTER_APPROVAL',
    pressure_pipe_vessel: 'PENDING_MASTER_APPROVAL',
    ele_equip_circuit: 'PENDING_MASTER_APPROVAL',
    main_anchor: 'PENDING_MASTER_APPROVAL'
  }.freeze

  MAINTENANCE_LIST = ['main_anchor'].freeze

  def retrieve_permit_type(permit_type_plain)
    permit_type = PERMIT_MAP[permit_type_plain.to_sym]
    raise "#{permit_type_plain} hasn't setup permit map" if permit_type.nil?

    permit_type
  end

  def retrieve_checklist_string(permit_type)
    check_list_str = CHECKLIST_MAP[permit_type.to_sym]
    raise "#{check_list_str} hasn't setup checklist map" if check_list_str.nil?

    check_list_str
  end

  def retrieve_approve_type(permit_type)
    approve_type = APPROVE_MAP[permit_type.to_sym]
    raise "#{permit_type} hasn't setup approve map" if approve_type.nil?

    approve_type
  end

  def maintenance_permit?(permit_type)
    MAINTENANCE_LIST.include? permit_type
  end
end
