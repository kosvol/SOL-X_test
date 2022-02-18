# frozen_string_literal: true

# class to retrieve maps
# To add new permit type, you need to add section0 and section4 checklist json to folder
# Also add checklist map here
class PermitMap
  PERMIT_MAP = {
    cold_work_in_hazardous: 'cold_work_in_hazardous',
    cold_work_cleaning_spill: 'cold_work_cleaning_spill',
    maintenance_on_anchor: 'maintenance_on_anchor',
    enclosed_spaces_entry: 'enclosed_spaces_entry',
    helicopter_operation: 'helicopter_operation',
    hot_work_outside_designated: 'hot_work_outside_designated',
    hot_work_designated: 'hot_work_designated',
    personnel_transfer: 'personnel_transfer',
    portable_tools: 'portable_tools',
    underwater_sim: 'underwater_sim',
    use_safe_camera: 'use_safe_camera',
    use_of_odme: 'use_of_odme',
    work_on_deck: 'work_on_deck',
    work_on_electrical_equipment: 'work_on_electrical_equipment',
    work_on_pipelines: 'work_on_pipelines',
    working_aloft: 'working_aloft',
    lifting_operation: 'lifting_operation',
    pressure_pipe_vessel: 'pressure_pipe_vessel',
    main_anchor: 'main_anchor',
    ele_equip_circuit: 'ele_equip_circuit',
    cre: 'cre',
    pre: 'pre'
  }.freeze

  CHECKLIST_MAP = {
    cold_work_cleaning_spill: 'openChecklistColdWorkOp',
    cold_work_in_hazardous: 'openChecklistWorkOnHazardousSubstances',
    enclosed_spaces_entry: 'openChecklistEnclosedSpaceEntry',
    helicopter_operation: 'openChecklistHelicopterOp',
    hot_work_outside_designated: 'openChecklistHotWorkOutsideDesignatedArea',
    hot_work_designated: 'openChecklistHotWorkWithinDesignatedArea',
    personnel_transfer: 'openChecklistPersonnelTransferByBasket',
    portable_tools: 'openChecklistRotationalPortablePowerTools',
    underwater_sim: 'openChecklistUnderwaterOp',
    use_safe_camera: 'openChecklistUseOfCamera',
    use_of_odme: 'openChecklistUseOfOdmeInManualMode',
    work_on_deck: 'openChecklistHeavyWeather',
    working_aloft: 'openChecklistWorkingAloftOverside',
    lifting_operation: 'openChecklistLiftingOperation',
    pressure_pipe_vessel: 'openChecklistPressurePipelines',
    ele_equip_circuit: 'openChecklistElectricalEquipmentAndCircuit',
    main_anchor: 'openChecklistCriticalEquipMaintenance'
  }.freeze

  APPROVE_MAP = {
    cold_work_cleaning_spill: 'PENDING_MASTER_APPROVAL',
    cold_work_in_hazardous: 'PENDING_MASTER_APPROVAL',
    maintenance_on_anchor: 'PENDING_MASTER_APPROVAL',
    enclosed_spaces_entry: 'PENDING_MASTER_APPROVAL',
    helicopter_operation: 'PENDING_MASTER_APPROVAL',
    hot_work_outside_designated: 'PENDING_OFFICE_APPROVAL',
    hot_work_designated: 'PENDING_MASTER_APPROVAL',
    personnel_transfer: 'PENDING_MASTER_APPROVAL',
    portable_tools: 'PENDING_MASTER_APPROVAL',
    underwater_sim: 'PENDING_OFFICE_APPROVAL',
    use_safe_camera: 'PENDING_OFFICE_APPROVAL',
    use_of_odme: 'PENDING_OFFICE_APPROVAL',
    work_on_deck: 'PENDING_MASTER_APPROVAL',
    work_on_electrical_equipment: 'PENDING_MASTER_APPROVAL',
    work_on_pipelines: 'PENDING_MASTER_APPROVAL',
    working_aloft: 'PENDING_MASTER_APPROVAL',
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
