# frozen_string_literal: true

require './././support/env'

class BypassPage < CommonFormsPage
  include PageObject

  def get_rank_id_from_service(_rank, _vessel = nil)
    if _vessel == nil
      ServiceUtil.post_graph_ql('pinpad/get-pin-by-role')
    else
      ServiceUtil.post_graph_ql_to_uri('pinpad/get-pin-by-role', '1111', _vessel)
    end
    ServiceUtil.get_response_body['data']['users'].each do |_crew|
      if _crew['crewMember']['rank'] === _rank
        CommonPage.set_rank_id = _crew['_id']
        break
      end
    end
  end

  def trigger_pre_submission(_user, _condition)
    create_form_pre = JSON.parse JsonUtil.read_json('pre/01.create-pre-form')
    create_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('pre/mod-01.create-pre-form', create_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-01.create-pre-form', _user)
    CommonPage.set_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])
    ServiceUtil.post_graph_ql('ship-local-time/base-get-current-time', _user)

    @get_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    start_time = "{\"dateTime\":\"#{get_current_minutes_time_with_offset}\",\"utcOffset\":#{@get_offset}}"
    p "start time >> #{start_time}"
    end_time = "{\"dateTime\":\"#{get_current_hours_time_with_offset(4)}\",\"utcOffset\":#{@get_offset}}"
    p "end time >> #{end_time}"
    gas_date = "\"#{get_current_date_time}\""
    update_form_pre = JSON.parse JsonUtil.read_json('pre/02.update-form-answers')
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['answers'][4]['value'] = start_time
    get_rank_id_from_service('C/O')
    update_form_pre['variables']['answers'][7]['value']['AUTO_SOLX0004'] = CommonPage.get_rank_id

    update_form_pre['variables']['answers'][7]['value']['2021-07-05T14:05:46.731Z'] = gas_date
    update_form_pre['variables']['answers'][21]['value'] = start_time
    update_form_pre['variables']['answers'][22]['value'] = end_time

    JsonUtil.create_request_file('pre/mod-02.update-form-answers', update_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-02.update-form-answers', _user)

    update_form_pre_status = JSON.parse JsonUtil.read_json('pre/03.update-form-status')
    update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/mod-03.update-form-status', update_form_pre_status)
    ServiceUtil.post_graph_ql('pre/mod-03.update-form-status', _user)

    # ServiceUtil.post_graph_ql('pre/mod-02.update-form-answers', _user)

    update_form_pre = JSON.parse JsonUtil.read_json('pre/07.before-change-status-to-approve')
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['answers'][3]['value'] = start_time
    update_form_pre['variables']['answers'][7]['value']['AUTO_SOLX0004'] = CommonPage.get_rank_id
    update_form_pre['variables']['answers'][7]['value']['2021-07-05T14:05:46.731Z'] = gas_date
    update_form_pre['variables']['answers'][21]['value'] = start_time
    update_form_pre['variables']['answers'][22]['value'] = end_time
    JsonUtil.create_request_file('pre/mod-07.before-change-status-to-approve', update_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-07.before-change-status-to-approve', _user)

    update_form_pre_status = JSON.parse JsonUtil.read_json('pre/04.update-form-status')
    update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/mod-04.update-form-status', update_form_pre_status)
    ServiceUtil.post_graph_ql('pre/mod-04.update-form-status', '2761')

    if _condition == 'activated'
      update_form_pre_status = JSON.parse JsonUtil.read_json('pre/05.update-form-status')
      update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
      update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
      JsonUtil.create_request_file('pre/05.update-form-status', update_form_pre_status)
      ServiceUtil.post_graph_ql('pre/05.update-form-status', '2761')
    end
    # ServiceUtil.post_graph_ql('pre/mod-07.before-change-status-to-approve', _user)
  end

  def terminate_pre_permit(_user)
    create_form_pre = JSON.parse JsonUtil.read_json('pre/05.submit-form-status-for-termination')
    create_form_pre['variables']['formId'] = CommonPage.get_permit_id
    create_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('pre/mod-05.submit-form-status-for-termination', create_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-05.submit-form-status-for-termination', _user)

    create_form_pre = JSON.parse JsonUtil.read_json('pre/06.update-form-status-for-termination')
    create_form_pre['variables']['formId'] = CommonPage.get_permit_id
    create_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('pre/mod-06.update-form-status-for-termination', create_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-06.update-form-status-for-termination', _user)
  end

  def trigger_forms_termination(_permit_type, _user, _vessel, _checklist, _eic, _gas)
    @via_service_or_not = true
    ### init ptw form
    create_form_ptw = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '0'))
    create_form_ptw['variables']['submissionTimestamp'] = get_current_date_time
    unless _checklist.nil?
      create_form_ptw['variables']['answers'][2].to_h['fieldId'] = $checklist_name_in_code_yml[_checklist]
    end
    JsonUtil.create_request_file('ptw/0.mod_create_form_ptw', create_form_ptw)
    ServiceUtil.post_graph_ql_to_uri('ptw/0.mod_create_form_ptw', _user, _vessel)
    CommonPage.set_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ### add time offset to ptw
    # add_time_offset_to_ptw = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '1'))
    # add_time_offset_to_ptw['variables']['id'] = CommonPage.get_permit_id
    # JsonUtil.create_request_file('ship-loca/1.mod_date_with_offset', add_time_offset_to_ptw)
    ServiceUtil.post_graph_ql_to_uri('ship-local-time/base-get-current-time', _user, _vessel)
    @get_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']

    ### init dra form
    init_dra = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '00'))
    init_dra['variables']['parentFormId'] = CommonPage.get_permit_id
    init_dra['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/0.mod_create_form_dra', init_dra)
    ServiceUtil.post_graph_ql_to_uri('ptw/0.mod_create_form_dra', _user, _vessel)
    CommonPage.set_dra_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    if _permit_type == 'submit_rigging_of_ladder'
      # DRA section
      _which_json = payload_mapper(_permit_type, '2')
      section = JSON.parse JsonUtil.read_json(_which_json)
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      JsonUtil.create_request_file('ptw/mod_2.save_rol_dra_section_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_2.save_rol_dra_section_details', _user, _vessel)

      # Checklist
      _which_json = payload_mapper(_permit_type, '3')
      section = JSON.parse JsonUtil.read_json(_which_json)
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      JsonUtil.create_request_file('ptw/mod_3.save_rol_checklist_section_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_3.save_rol_checklist_section_details', _user, _vessel)

      submit_active = set_permit_status('PENDING_MASTER_APPROVAL')
      submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

      submit_active = set_permit_status('ACTIVE')
      submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

      section = JSON.parse JsonUtil.read_json('ptw/rol/16.update-active-status_rol')
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      section['variables']['answers'][1].to_h['value'] =
        "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
      section['variables']['answers'][2].to_h['value'] = '"2"'
      get_rank_id_from_service('MAS', _vessel)
      section['variables']['answers'][3].to_h['value']['signedBy'] = CommonPage.get_rank_id
      section['variables']['answers'].last['value'] =
        "{\"dateTime\":\"#{get_current_date_time_cal(2)}\",\"utcOffset\":#{@get_offset}}"
      JsonUtil.create_request_file('ptw/mod_16.update-active-status_rol', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_16.update-active-status_rol', _user, _vessel)

      section = JSON.parse JsonUtil.read_json('ptw/rol/17.save_rol_task_status_section_details')
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      get_rank_id_from_service('A/M', _vessel)
      section['variables']['answers'][10]['value']['AUTO_SOLX0012'] = CommonPage.get_rank_id
      JsonUtil.create_request_file('ptw/mod_17.save_rol_task_status_section_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_17.save_rol_task_status_section_details', _user, _vessel)

      submit_active = set_permit_status('PENDING_TERMINATION')
      submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

      section = JSON.parse JsonUtil.read_json('ptw/rol/20.save_rol_task_status_before_termination')
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      get_rank_id_from_service('MAS', _vessel)
      section['variables']['answers'].last['value'] =
        "{\"signedBy\":\"#{CommonPage.get_rank_id}\",\"signatureString\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABYAyADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIH/8QAGxABAQEAAwEBAAAAAAAAAAAAAAECAxEhIjH/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A2YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARy8ueHE1qbsus5+MXV7tknkl87vt/JO7epLVgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//Z\",\"signedOn\":{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}}"
      JsonUtil.create_request_file('ptw/mod_20.save_rol_task_status_before_termination', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_20.save_rol_task_status_before_termination', _user, _vessel)
    else

      ### Section 1
      _which_json = payload_mapper(_permit_type, '3')
      section = JSON.parse JsonUtil.read_json("ptw/#{_which_json}")
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      if $current_environment === 'sit' #todo: need to fix that with actual
        section['variables']['answers'].last['value']["#{EnvironmentSelector.get_beacons_env_prefix}-Z-AFT-STATION"] =
          '000000YGJ11ZSESBYNRXYRVVN3'
      end
      JsonUtil.create_request_file('ptw/mod_3.save_section1_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_3.save_section1_details', _user, _vessel)

      ### Section 3b
      _which_json = payload_mapper(_permit_type, '3b')
      section = JSON.parse JsonUtil.read_json("ptw/#{_which_json}")
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      JsonUtil.create_request_file('ptw/mod_3b.save_section3b_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_3b.save_section3b_details', _user, _vessel)

      ### Section 3d
      section3d = JSON.parse JsonUtil.read_json('ptw/8.save_section3d_details')
      section3d['variables']['formId'] = CommonPage.get_permit_id
      section3d['variables']['submissionTimestamp'] = get_current_date_time
      section3d['variables']['answers'].last['value'] = get_default_signature_payload
      JsonUtil.create_request_file('ptw/mod_8.save_section3d_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_8.save_section3d_details', _user, _vessel)

      ### Section 4a with no checklists
      if _checklist.nil?
        section = JSON.parse JsonUtil.read_json('ptw/21.save_section4a_details')
        section['variables']['formId'] = CommonPage.get_permit_id
        section['variables']['submissionTimestamp'] = get_current_date_time
        get_rank_id_from_service('A/M')
        JsonUtil.create_request_file('ptw/mod_21.save_section4a_details', section)
        ServiceUtil.post_graph_ql_to_uri('ptw/mod_21.save_section4a_details', _user, _vessel)
      end
      ### create eic ###
      unless _eic.nil?
        create_eic = JSON.parse JsonUtil.read_json('ptw/11.create_eic')
        create_eic['variables']['parentFormId'] = CommonPage.get_permit_id
        create_eic['variables']['submissionTimestamp'] = get_current_date_time
        JsonUtil.create_request_file('ptw/mod_11.create_eic', create_eic)
        ServiceUtil.post_graph_ql_to_uri('ptw/mod_11.create_eic', _user, _vessel)

        ### save eic cert details ###
        save_eic = JSON.parse JsonUtil.read_json('ptw/11.save_eic_cert_details')
        save_eic['variables']['parentFormId'] = CommonPage.get_permit_id
        save_eic['variables']['formId'] = ServiceUtil.get_response_body['data']['createForm']['_id']
        save_eic['variables']['submissionTimestamp'] = get_current_date_time
        JsonUtil.create_request_file('ptw/mod_11.save_eic_cert_details', save_eic)
        ServiceUtil.post_graph_ql_to_uri('ptw/mod_11.save_eic_cert_details', _user, _vessel)

        ### section 4b ###
        section4b = JSON.parse JsonUtil.read_json('ptw/11.save_section4b_details')
        section4b['variables']['formId'] = CommonPage.get_permit_id
        section4b['variables']['submissionTimestamp'] = get_current_date_time
        if _eic === 'eic_yes'
          section4b['variables']['answers'][1].to_h['value'] = '"yes"'
          get_rank_id_from_service('C/O')
          section4b['variables']['answers'].last['value'] =
            "{\"signedBy\":\"#{CommonPage.get_rank_id}\",\"signatureString\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABYAyADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIH/8QAGxABAQEAAwEBAAAAAAAAAAAAAAECAxEhIjH/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A2YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARy8ueHE1qbsus5+MXV7tknkl87vt/JO7epLVgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//Z\",\"signedOn\":{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}}"
        elsif _eic === 'eic_no'
          section4b['variables']['answers'][1].to_h['value'] = '"no"'
          section4b['variables']['answers'].pop
        end
        JsonUtil.create_request_file('ptw/mod_11.save_section4b_details', section4b)
        ServiceUtil.post_graph_ql_to_uri('ptw/mod_11.save_section4b_details', _user, _vessel)
      end

      ### Section 5
      section = JSON.parse JsonUtil.read_json('ptw/12.save_section5_details')
      section['variables']['formId'] = CommonPage.get_permit_id
      section['variables']['submissionTimestamp'] = get_current_date_time
      JsonUtil.create_request_file('ptw/mod_12.save_section5_details', section)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_12.save_section5_details', _user, _vessel)

      ### Section 6
      unless _gas.nil?
        section2 = JSON.parse JsonUtil.read_json('ptw/13.save_section6_details')
        section2['variables']['formId'] = CommonPage.get_permit_id
        section2['variables']['submissionTimestamp'] = get_current_date_time
        if _gas === 'gas_yes'
          section2['variables']['answers'][1].to_h['value'] = '"yes"'
        elsif _gas === 'gas_no'
          section2['variables']['answers'][1].to_h['value'] = '"no"'
          section2['variables']['answers'].delete_at(2)
          section2['variables']['answers'].delete_at(2)
          section2['variables']['answers'].delete_at(2)
        end
        JsonUtil.create_request_file('ptw/mod_13.save_section6_details', section2)
        ServiceUtil.post_graph_ql_to_uri('ptw/mod_13.save_section6_details', _user, _vessel)
      end

      submit_active = set_permit_status('PENDING_MASTER_APPROVAL')
      submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

      submit_active = set_permit_status('ACTIVE')
      submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

      # ##Section 7b
      _update_permit = JSON.parse JsonUtil.read_json('ptw/16.update-active-status')
      _update_permit['variables']['formId'] = CommonPage.get_permit_id
      _update_permit['variables']['submissionTimestamp'] = get_current_date_time
      _update_permit['variables']['answers'][3].to_h['value'] =
        "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
      _update_permit['variables']['answers'].last['value'] =
        "{\"dateTime\":\"#{get_current_date_time_cal(8)}\",\"utcOffset\":#{@get_offset}}"
      JsonUtil.create_request_file('ptw/mod_16.update-active-status', _update_permit)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_16.update-active-status', _user, _vessel)
      sleep(2)

      ### Section 8
      submit_active = JSON.parse JsonUtil.read_json('ptw/17.submit-for-termination-wo-eic-normalization')
      submit_active['variables']['formId'] = CommonPage.get_permit_id
      submit_active['variables']['submissionTimestamp'] = get_current_date_time
      submit_active['variables']['answers'][2].to_h['value'] =
        "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
      submit_active['variables']['answers'][4].to_h['value'] = '"Completed"'
      submit_active['variables']['answers'][5].to_h['value'] =
        "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
      JsonUtil.create_request_file('ptw/mod_17.submit-for-termination-wo-eic-normalization', submit_active)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_17.submit-for-termination-wo-eic-normalization', _user, _vessel)

      submit_active = set_permit_status('PENDING_TERMINATION')
      submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

      ### Section 9
      submit_active = JSON.parse JsonUtil.read_json('ptw/20.save_section9_details')
      submit_active['variables']['formId'] = CommonPage.get_permit_id
      submit_active['variables']['submissionTimestamp'] = get_current_date_time
      submit_active['variables']['answers'][2].to_h['value'] =
        "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
      submit_active['variables']['answers'].last['value'] =
        "{\"signedBy\":\"#{CommonPage.get_rank_id}\",\"signatureString\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABYAyADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIH/8QAGxABAQEAAwEBAAAAAAAAAAAAAAECAxEhIjH/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A2YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARy8ueHE1qbsus5+MXV7tknkl87vt/JO7epLVgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//Z\",\"signedOn\":{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}}"
      JsonUtil.create_request_file('ptw/mod_20.save_section9_details', submit_active)
      ServiceUtil.post_graph_ql_to_uri('ptw/mod_20.save_section9_details', _user, _vessel)
    end
    submit_active = set_permit_status('CLOSED')
    submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)
  end

  def trigger_forms_submission(_permit_type = nil, _user, _state, eic, _gas)
    @via_service_or_not = true
    ### init ptw form
    create_form_ptw = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '0'))
    create_form_ptw['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('C/O')
    create_form_ptw['variables']['answers'][0]['value'] =
      create_form_ptw['variables']['answers'][0]['value'].gsub('AUTO_SOLX0012',
                                                               (CommonPage.get_rank_id).to_s)
    JsonUtil.create_request_file('ptw/0.mod_create_form_ptw', create_form_ptw)
    ServiceUtil.post_graph_ql('ptw/0.mod_create_form_ptw', _user)
    CommonPage.set_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ### add time offset to ptw
    ServiceUtil.post_graph_ql('ship-local-time/base-get-current-time', _user)
    @get_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']

    ### init dra form
    init_dra = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '00'))
    init_dra['variables']['parentFormId'] = CommonPage.get_permit_id
    init_dra['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/0.mod_create_form_dra', init_dra)
    ServiceUtil.post_graph_ql('ptw/0.mod_create_form_dra', _user)
    CommonPage.set_dra_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ### Section 1
    _which_json = payload_mapper(_permit_type, '3')
    section = JSON.parse JsonUtil.read_json("ptw/#{_which_json}")
    section['variables']['formId'] = CommonPage.get_permit_id
    section['variables']['submissionTimestamp'] = get_current_date_time
    if $current_environment === 'sit'
      section['variables']['answers'].last['value']['AUTO-Z-AFT-STATION'] = "#{EnvironmentSelector.get_beacons_env_prefix}_000000YGJ11ZSESBYNRXYRVVN3"
    end
    JsonUtil.create_request_file('ptw/mod_3.save_section1_details', section)
    ServiceUtil.post_graph_ql('ptw/mod_3.save_section1_details', _user)

    save_different_form_section(payload_mapper(_permit_type, '4'), _user)

    ### section 3a ###
    section3a = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '3a'))
    section3a['variables']['formId'] = CommonPage.get_permit_id
    section3a['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_5.save_section3a_details', section3a)
    ServiceUtil.post_graph_ql('ptw/mod_5.save_section3a_details', _user)
    ### end ###

    ### section 3b ###
    _which_json = payload_mapper(_permit_type, '3b')
    section3b = JSON.parse JsonUtil.read_json("ptw/#{_which_json}")
    section3b['variables']['formId'] = CommonPage.get_permit_id
    section3b['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('MAS')
    section3b['variables']['answers'][2]['value'] =
      "[{\"userId\":\"#{CommonPage.get_rank_id}\",\"rank\":\"MAS\"}]"
    JsonUtil.create_request_file('ptw/mod_6.save_section3b_details', section3b)
    ServiceUtil.post_graph_ql('ptw/mod_6.save_section3b_details', _user)

    ### section 3c ###
    section3c = JSON.parse JsonUtil.read_json('ptw/7.save_section3c_details')
    section3c['variables']['formId'] = CommonPage.get_permit_id
    section3c['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('A/M')
    section3c['variables']['answers'][0]['value'] =
      "[{\"userId\":\"#{CommonPage.get_rank_id}\",\"rank\":\"A/M\"}]"
    JsonUtil.create_request_file('ptw/mod_7.save_section3c_details', section3c)
    ServiceUtil.post_graph_ql('ptw/mod_7.save_section3c_details', _user)

    ### section 3d ###
    section3d = JSON.parse JsonUtil.read_json('ptw/8.save_section3d_details')
    section3d['variables']['formId'] = CommonPage.get_permit_id
    section3d['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('A/M')
    section3d['variables']['answers'][-1]['value'] = get_default_signature_payload
    JsonUtil.create_request_file('ptw/mod_8.save_section3d_details', section3d)
    ServiceUtil.post_graph_ql('ptw/mod_8.save_section3d_details', _user)

    save_different_form_section(payload_mapper(_permit_type, '4a'), _user)

    ### section 4ac ###
    section4ac = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '4ac'))
    section4ac['variables']['formId'] = CommonPage.get_permit_id
    section4ac['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('C/E')
    section4ac['variables']['answers'][-1]['value'] = get_default_signature_payload
    JsonUtil.create_request_file('ptw/mod_10.save_section4a_checklist_details', section4ac)
    ServiceUtil.post_graph_ql('ptw/mod_10.save_section4a_checklist_details', _user)

    ### create eic ###
    create_eic = JSON.parse JsonUtil.read_json('ptw/11.create_eic')
    create_eic['variables']['parentFormId'] = CommonPage.get_permit_id
    create_eic['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_11.create_eic', create_eic)
    ServiceUtil.post_graph_ql('ptw/mod_11.create_eic', _user)

    ### save eic cert details ###
    save_eic = JSON.parse JsonUtil.read_json('ptw/11.save_eic_cert_details')
    save_eic['variables']['parentFormId'] = CommonPage.get_permit_id
    save_eic['variables']['formId'] = ServiceUtil.get_response_body['data']['createForm']['_id']
    save_eic['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('C/O')
    save_eic['variables']['answers'][-3]['value'] = get_default_signature_payload
    get_rank_id_from_service('C/E')
    save_eic['variables']['answers'][-2]['value'] = get_default_signature_payload
    JsonUtil.create_request_file('ptw/mod_11.save_eic_cert_details', save_eic)
    ServiceUtil.post_graph_ql('ptw/mod_11.save_eic_cert_details', _user)

    ### section 4b ###
    section4b = JSON.parse JsonUtil.read_json('ptw/11.save_section4b_details')
    section4b['variables']['formId'] = CommonPage.get_permit_id
    section4b['variables']['submissionTimestamp'] = get_current_date_time
    if eic === 'eic_yes'
      section4b['variables']['answers'][1].to_h['value'] = '"yes"'
      get_rank_id_from_service('A/M')
      section4b['variables']['answers'].last['value'] = get_default_signature_payload
    elsif eic === 'eic_no'
      section4b['variables']['answers'][1].to_h['value'] = '"no"'
      section4b['variables']['answers'].pop
    end
    JsonUtil.create_request_file('ptw/mod_11.save_section4b_details', section4b)
    ServiceUtil.post_graph_ql('ptw/mod_11.save_section4b_details', _user)
    ### end ###

    ### section 5 ###
    section5 = JSON.parse JsonUtil.read_json('ptw/12.save_section5_details')
    section5['variables']['formId'] = CommonPage.get_permit_id
    get_rank_id_from_service('C/O')
    section5['variables']['answers'].last['value'] =
      "[{\"crewId\":\"#{CommonPage.get_rank_id}\",\"role\":\"Authorized Entrant 1\",\"signed\":{\"userId\":\"#{CommonPage.get_rank_id}\",\"rank\":\"A/M\"},\"signature\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABYAyADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIH/8QAGhABAAMAAwAAAAAAAAAAAAAAAAECAwQRMf/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwDZgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARjjlx8M8MMqZZZVilM6Vita1iOoiIjyIhYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//Z\",\"signedAt\":\"#{EnvironmentSelector.get_beacons_env_prefix}-Z-AFT-STATION\",\"signedOn\":{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}}]"
    JsonUtil.create_request_file('ptw/mod_12.save_section5_details', section5)
    ServiceUtil.post_graph_ql('ptw/mod_12.save_section5_details', _user)
    ### end ###

    ### section 6 ###
    section2 = JSON.parse JsonUtil.read_json('ptw/13.save_section6_details')
    section2['variables']['formId'] = CommonPage.get_permit_id
    section2['variables']['submissionTimestamp'] = get_current_date_time
    if _gas === 'gas_yes'
      section2['variables']['answers'][1].to_h['value'] = '"yes"'
      get_rank_id_from_service('A/M')
      section2['variables']['answers'][-3]['value'] =
        "[{\"formId\":\"\",\"entryId\":\"entry\",\"crewId\":\"#{CommonPage.get_rank_id}\",\"gasReadings\":[{\"gasName\":\"O2\",\"reading\":\"1\",\"unit\":\"%\",\"threshold\":\"20.9\"},{\"gasName\":\"HC\",\"reading\":\"2\",\"unit\":\"% LEL\",\"threshold\":\"1\"},{\"gasName\":\"H2S\",\"reading\":\"3\",\"unit\":\"PPM\",\"threshold\":\"5\"},{\"gasName\":\"CO\",\"reading\":\"4\",\"unit\":\"PPM\",\"threshold\":\"25\"}],\"gasReadingTime\":{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}},\"signature\":\"data:image/jpeg;base64,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\",\"signed\":{\"userId\":\"#{CommonPage.get_rank_id}\",\"rank\":\"A/M\"},\"gasReadingStatus\":\"PENDING\",\"entryStatus\":\"ACTIVE\",\"purposeOfEntry\":\"\",\"entrant\":{\"clientId\":\"\",\"_id\":\"#{CommonPage.get_rank_id}\",\"accessGroups\":[],\"firstName\":\"COT\",\"lastName\":\"A/M\",\"rank\":\"A/M\"},\"locationId\":\"#{EnvironmentSelector.get_beacons_env_prefix}-Z-AFT-STATION\"}]"
      get_rank_id_from_service('A/M')
      section2['variables']['answers'][-2]['value'] = get_default_signature_payload
    elsif _gas === 'gas_no'
      section2['variables']['answers'][1].to_h['value'] = '"no"'
      section2['variables']['answers'].delete_at(2)
      section2['variables']['answers'].delete_at(2)
      section2['variables']['answers'].delete_at(2)
    end
    JsonUtil.create_request_file('ptw/mod_13.save_section6_details', section2)
    ServiceUtil.post_graph_ql('ptw/mod_13.save_section6_details', _user)

    ### SUBMIT ###
    save_different_form_section(payload_mapper(_permit_type, '14'), _user)

    ### put to states
    if _state === 'active'
      submit_active = set_permit_status('ACTIVE')
      submit_permit_for_status_change(submit_active, _user, _permit_type)
      set_update_require_for_permit(_permit_type, _user)
    end
    ### End submit states
  end

  def submit_permit_for_status_change_to_uri(_submit_active, _user, _permit_type, _uri)
    _submit_active['variables']['formId'] = CommonPage.get_permit_id
    _submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', _submit_active)
    ServiceUtil.post_graph_ql_to_uri('ptw/mod_15.submit-to-active', _user, _uri)
  end

  def submit_permit_for_status_change(_submit_active, _user, _permit_type)
    _submit_active['variables']['formId'] = CommonPage.get_permit_id
    _submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', _submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active', _user)
  end

  def set_update_require_for_permit(_permit_type, _user)
    _update_permit = JSON.parse JsonUtil.read_json('ptw/16.update-active-status')
    _update_permit['variables']['formId'] = CommonPage.get_permit_id
    _update_permit['variables']['submissionTimestamp'] = get_current_date_time
    _update_permit['variables']['answers'][2]['value'] = get_default_signature_payload
    _update_permit['variables']['answers'][3].to_h['value'] =
      "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
    if _permit_type != 'submit_underwater_simultaneou'
      _update_permit['variables']['answers'].last['value'] =
        "{\"dateTime\":\"#{get_current_date_time_cal(8)}\",\"utcOffset\":#{@get_offset}}"
    else
      _update_permit['variables']['answers'].last['value'] =
        "{\"dateTime\":\"#{get_current_date_time_cal(4)}\",\"utcOffset\":#{@get_offset}}"
    end
    JsonUtil.create_request_file('ptw/mod_16.update-active-status', _update_permit)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status', _user)
  end

  def set_permit_status(_status)
    submit_status = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_status['variables']['newStatus'] = _status
    submit_status
  end

  def set_oa_permit_to_state(_whatState)
    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['newStatus'] = _whatState
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')
  end

  def set_oa_permit_to_pending_office_appr
    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['newStatus'] = 'PENDING_OFFICE_APPROVAL'
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')
  end

  def set_oa_permit_to_active_state(status)
    url = EnvironmentSelector.get_edge_db_data_by_uri("forms/#{CommonPage.get_permit_id.gsub('/', '%2F')}?conflicts=true")
    ServiceUtil.fauxton(url, 'get')
    permit_payload = JSON.parse ServiceUtil.get_response_body.to_s
    permit_payload['status'] = status
    ServiceUtil.fauxton(url, 'put', permit_payload.to_json)

    submit_active = JSON.parse JsonUtil.read_json('ptw/16.update-active-status')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    submit_active['variables']['answers'][3].to_h['value'] =
      "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'].last['value'] =
      "{\"dateTime\":\"#{get_current_date_time_cal(8)}\",\"utcOffset\":#{get_current_time_offset}}"
    JsonUtil.create_request_file('ptw/mod_16.update-active-status', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status')
  end

  def set_non_oa_permit_to_active_state
    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    set_current_time
    reset_data_collector
    # @@created_permit_data = set_section1_filled_data
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')

    submit_active = JSON.parse JsonUtil.read_json('ptw/16.update-active-status')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    submit_active['variables']['answers'][3].to_h['value'] =
      "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'].last['value'] =
      "{\"dateTime\":\"#{get_current_date_time_cal(2)}\",\"utcOffset\":#{get_current_time_offset}}"
    JsonUtil.create_request_file('ptw/mod_16.update-active-status', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status')
  end

  def set_rol_to_active(_duration)
    yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')

    submit_active = JSON.parse JsonUtil.read_json('ptw/rol/16.update-active-status_rol')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['answers'][1].to_h['value'] =
      "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'][2].to_h['value'] = "\"#{_duration}\""
    submit_active['variables']['answers'].last['value'] =
      "{\"dateTime\":\"#{get_current_date_time_cal(_duration)}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    get_rank_id_from_service('MAS')
    section['variables']['answers'][3].to_h['value']['signedBy'] = "\"#{CommonPage.get_rank_id}\""

    JsonUtil.create_request_file('ptw/mod_16.update-active-status_rol', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status_rol')
  end

  def submit_permit_for_termination_wo_eic_normalization(_status)
    yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
    submit_active = JSON.parse JsonUtil.read_json('ptw/17.submit-for-termination-wo-eic-normalization')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['answers'][2].to_h['value'] =
      "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'][4].to_h['value'] = "\"#{_status}\""
    get_rank_id_from_service('A/M')
    submit_active['variables']['answers'][-2].to_h['value']['signedBy'] = (CommonPage.get_rank_id).to_s
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod-17.submit-for-termination-wo-eic-normalization', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod-17.submit-for-termination-wo-eic-normalization')

    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['newStatus'] = 'PENDING_TERMINATION'
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')
  end

  def cal_new_hour_offset_time(_offset)
    @current_time = Time.now.utc.strftime('%H')
    begin
      time_w_offset = @current_time.to_i + _offset.to_i
    rescue StandardError
      time_w_offset = @current_time.to_i + get_current_time_offset.to_i
    end
    count_hour = if time_w_offset >= 24
        (time_w_offset - 24).abs
      else
        time_w_offset
      end
    count_hour.to_s.size === 2 ? count_hour.to_s : "0#{count_hour}"
  end

  def create_entry_record(_array, _type)
    ServiceUtil.post_graph_ql('pinpad/get-pin-by-role')
    case _type
    when 'CRE', 'PRE'
      _entry_record = JSON.parse JsonUtil.read_json('cre/09.add_entry')
      _entry_record['variables']['formId'] = CommonPage.get_permit_id

      _array.split(',').each do |item|
        ServiceUtil.get_response_body['data']['users'].each do |crew|
          if crew['crewMember']['rank'] === item
            _entry_record['variables']['otherEntrantIds'].push(crew['_id'])
            break
          end
          #id = yml_id["ranks_id_#{ENV['ENVIRONMENT']}"][item]
        end
      end
      get_rank_id_from_service('A C/O')
      _entry_record['variables']['crew_id'] = CommonPage.get_rank_id
      JsonUtil.create_request_file('cre/09.mod_add_entry', _entry_record)
      ServiceUtil.post_graph_ql('cre/09.mod_add_entry')
    when 'PTW'
      _entry_record = JSON.parse JsonUtil.read_json('ptw/18.create_entry_record')
      _entry_record['variables']['formId'] = CommonPage.get_permit_id
      _array.split(',').each do |item|
        ServiceUtil.get_response_body['data']['users'].each do |crew|
          if crew['crewMember']['rank'] === item
            _entry_record['variables']['otherEntrantIds'].push(crew['_id'])
            break
          end
          #id = yml_id["ranks_id_#{ENV['ENVIRONMENT']}"][item]
        end
        #id = yml_id["ranks_id_#{ENV['ENVIRONMENT']}"][item]
        #puts(ENV['ENVIRONMENT'])
        # _entry_record['variables']['otherEntrantIds'].push(id)
      end
      JsonUtil.create_request_file('ptw/18.mod_create_entry_record', _entry_record)
      ServiceUtil.post_graph_ql('ptw/18.mod_create_entry_record')
    else
      raise 'Wrong Permit Type'
    end
  end

  def create_entry_record_custom_gas_readings(_array, _type)
    ServiceUtil.post_graph_ql('pinpad/get-pin-by-role')
    if (_type == 'CRE') || (_type == 'PRE')
      permit = 'cre/09.add_entry_custom_readings'
      permit_mod = 'cre/09.mod_add_entry_custom_readings'
    elsif _type == 'PTW'
      permit = '18.create_new_entry_custom_readings'
      permit_mod = '18.create_new_entry_custom_readings'
    else
      raise 'wrong type'
    end

    _entry_record = JSON.parse JsonUtil.read_json(permit)
    _entry_record['variables']['formId'] = CommonPage.get_permit_id
    _array.split(',').each do |item|
      ServiceUtil.get_response_body['data']['users'].each do |crew|
        if crew['crewMember']['rank'] === item
          _entry_record['variables']['otherEntrantIds'].push(crew['_id'])
          break
        end
        #id = yml_id["ranks_id_#{ENV['ENVIRONMENT']}"][item]
      end
      _entry_record['variables']['gasReadings'][0]['reading'] = '99'
    end
    get_rank_id_from_service('A C/O')
    _entry_record['variables']['crewId'] = CommonPage.get_rank_id if (_type == 'CRE') || (_type == 'PRE')
    JsonUtil.create_request_file(permit_mod, _entry_record)
    ServiceUtil.post_graph_ql(permit_mod)
  end

  def signout_entrants(_entrant_name)
    _entry_record = JSON.parse JsonUtil.read_json('cre/08.signout_entrants')
    _entry_record['variables']['formId'] = CommonPage.get_permit_id
    yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
    get_rank_id_from_service(_entrant_name)
    _entry_record['variables']['crewId'] = CommonPage.get_rank_id
    JsonUtil.create_request_file('cre/18.mod_signout_entrants', _entry_record)
    ServiceUtil.post_graph_ql('cre/18.mod_signout_entrants')
  end

  def close_permit(_permit_type, _user, _vessel)
    submit_active = set_permit_status('PENDING_TERMINATION')
    submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)

    submit_active = set_permit_status('CLOSED')
    submit_permit_for_status_change_to_uri(submit_active, _user, _permit_type, _vessel)
  end

  def trigger_cre_submission(_user, _time)
    get_rank_id_from_service('A C/O')
    create_form_pre = JSON.parse JsonUtil.read_json('cre/01.create-cre-form')
    create_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('cre/mod-01.create-cre-form', create_form_pre)
    ServiceUtil.post_graph_ql('cre/mod-01.create-cre-form', _user)
    CommonPage.set_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])
    ServiceUtil.post_graph_ql('ship-local-time/base-get-current-time', _user)
    @get_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    if _time == 'current'
      start_time = "{\"dateTime\":\"#{get_current_minutes_time_with_offset}\",\"utcOffset\":#{@get_offset}}"
      p "start time >> #{start_time}"
      end_time = "{\"dateTime\":\"#{get_current_hours_time_with_offset(4)}\",\"utcOffset\":#{@get_offset}}"
    else
      start_time = "{\"dateTime\":\"#{get_current_date_time_cal(24)}\",\"utcOffset\":#{@get_offset}}"
      p "start time >> #{start_time}"
      end_time = "{\"dateTime\":\"#{get_current_hours_time_with_offset(28)}\",\"utcOffset\":#{@get_offset}}"
    end
    p "end time >> #{end_time}"
    # @get_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    # start_time = "{\"dateTime\":\"#{get_current_minutes_time_with_offset}\",\"utcOffset\":#{@get_offset}}"
    # p "start time >> #{start_time}"
    # end_time = "{\"dateTime\":\"#{get_current_hours_time_with_offset(4)}\",\"utcOffset\":#{@get_offset}}"
    # p "end time >> #{end_time}"
    @@startTime = get_current_minutes_time_with_offset
    update_form_pre = JSON.parse JsonUtil.read_json('cre/02.update-form-answers')
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['answers'][4]['value'] = start_time
    update_form_pre['variables']['answers'][7]['value']['2021-02-19T13:00:13.786Z'] = get_current_date_time
    update_form_pre['variables']['answers'][8]['value'] = start_time
    update_form_pre['variables']['answers'][9]['value'] = end_time
    update_form_pre['variables']['answers'][11]['value']['2021-02-19T13:00:46.786Z'] = get_current_date_time
    yml_id = YAML.load_file('data/sit_rank_and_pin.yml')
    update_form_pre['variables']['answers'][7]['value']['AUTO_SOLX0012'] =
      CommonPage.get_rank_id
    update_form_pre['variables']['answers'][7]['value']['AUTO_SOLX0012'] =
      CommonPage.get_rank_id
    JsonUtil.create_request_file('cre/mod-02.update-form-answers', update_form_pre)
    ServiceUtil.post_graph_ql('cre/mod-02.update-form-answers', _user)

    update_form_pre_status = JSON.parse JsonUtil.read_json('cre/03.update-form-status')
    update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('cre/mod-03.update-form-status', update_form_pre_status)
    ServiceUtil.post_graph_ql('cre/mod-03.update-form-status', _user)

    # ServiceUtil.post_graph_ql('pre/mod-02.update-form-answers', _user)

    update_form_pre = JSON.parse JsonUtil.read_json('cre/07.before-change-status-to-approve')
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['answers'][4]['value'] = start_time
    update_form_pre['variables']['answers'][7]['value']['2021-02-19T13:00:13.786Z'] = get_current_date_time
    update_form_pre['variables']['answers'][8]['value'] = start_time
    update_form_pre['variables']['answers'][9]['value'] = end_time
    update_form_pre['variables']['answers'][11]['value']['2021-02-19T13:06:33.658Z'] = get_current_date_time
    update_form_pre['variables']['answers'][12]['value']['2021-02-19T13:07:00.658Z'] = get_current_date_time
    update_form_pre['variables']['answers'][7]['value']['AUTO_SOLX0012'] =
      CommonPage.get_rank_id
    update_form_pre['variables']['answers'][7]['value']['AUTO_SOLX0012'] =
      CommonPage.get_rank_id
    update_form_pre['variables']['answers'][11]['value']['AUTO_SOLX0004'] =
      #yml_id["ranks_id_#{ENV['ENVIRONMENT']}"]['C/O']
      CommonPage.get_rank_id
    update_form_pre['variables']['answers'][12]['value']['AUTO_SOLX0005'] =
      CommonPage.get_rank_id
    JsonUtil.create_request_file('cre/mod-07.before-change-status-to-approve', update_form_pre)
    ServiceUtil.post_graph_ql('cre/mod-07.before-change-status-to-approve', _user)

    update_form_pre_status = JSON.parse JsonUtil.read_json('pre/04.update-form-status')
    update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/mod-04.update-form-status', update_form_pre_status)
    ServiceUtil.post_graph_ql('pre/mod-04.update-form-status', '2761')

    update_form_pre_status = JSON.parse JsonUtil.read_json('pre/05.update-form-status')
    update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/mod-05.update-form-status', update_form_pre_status)
    ServiceUtil.post_graph_ql('pre/mod-05.update-form-status', '2761')

    # ServiceUtil.post_graph_ql('pre/mod-07.before-change-status-to-approve', _user)
  end

  def activate_pre_cre
    update_form_pre_status = JSON.parse JsonUtil.read_json('pre/05.update-form-status')
    update_form_pre_status['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre_status['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/mod-05.update-form-status', update_form_pre_status)
    ServiceUtil.post_graph_ql('pre/mod-05.update-form-status', '8383')
  end

  def get_users
    ServiceUtil.post_graph_ql('get_users', '2761')
    json_body = ServiceUtil.get_response_body
    JSON.parse(json_body)
  end

  private

  def get_default_signature_payload
    "{\"signedBy\":\"#{CommonPage.get_rank_id}\",\"signedBy\":\"#{CommonPage.get_rank_id}\",\"signatureString\":\"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIfIiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABYAyADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIH/8QAGxABAQEAAwEBAAAAAAAAAAAAAAECAxEhIjH/xAAUAQEAAAAAAAAAAAAAAAAAAAAA/8QAFBEBAAAAAAAAAAAAAAAAAAAAAP/aAAwDAQACEQMRAD8A2YAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARy8ueHE1qbsus5+MXV7tknkl87vt/JO7epLVgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA//Z\",\"signedAt\":\"#{EnvironmentSelector.get_beacons_env_prefix}-Z-AFT-STATION\",\"signedOn\":{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}}"
  end

  def cal_new_minutes_offset_time
    @current_minute = Time.now.utc.strftime('%M')
    current_minute = @current_minute.to_i + 1
    if current_minute > 60
      current_minute -= 60
      current_minute.to_s.size === 2 ? current_minute.to_s : "0#{current_minute}"
    else
      current_minute.to_s.size === 2 ? current_minute.to_s : "0#{current_minute}"
    end
  end

  def save_different_form_section(_which_json, _user)
    section = JSON.parse JsonUtil.read_json("ptw/#{_which_json}")
    section['variables']['formId'] = CommonPage.get_permit_id
    section['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file("ptw/mod#{_which_json.sub('/', '')}", section)
    ServiceUtil.post_graph_ql("ptw/mod#{_which_json.sub('/', '')}", _user)
  end

  def get_current_hours_time_with_offset(_offset)
    Time.now.utc.strftime("%Y-%m-%dT#{cal_new_hour_offset_time(_offset)}:%M:%S.000Z")
  end

  def get_current_minutes_time_with_offset
    Time.now.utc.strftime("%Y-%m-%dT%H:#{cal_new_minutes_offset_time}:%S.000Z")
  end

  def get_current_date_time
    Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  # def get_current_date
  #   Time.now.utc.strftime('%Y-%m-%dT12:00:00.000Z')
  # end

  # def get_issued_time
  #   @@issued_time = Time.now.utc.strftime('H:%M')
  # end

  def get_current_date_time_cal(_duration)
    # tmp = (Time.now + (60 * 60 * _duration.to_i)).utc.strftime('%H')
    # Time.now.utc.strftime("%Y-%m-%dT#{tmp}:%M:%S.901Z")
    (Time.now + (60 * 60 * _duration.to_i)).utc.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  def payload_mapper(permit_name, _step)
    case permit_name
    when 'submit_non_intrinsical_camera'
      case _step
      when '0'
        'ptw/camera/0.create_form_ptw'
      when '00'
        'ptw/camera/0.create_form_dra'
      when '1'
        'ship-local-time/base-get-current-time'
      when '2'
        'ptw/camera/2.save_section0_details'
      when '3'
        'camera/3.save_section1_details'
      when '4'
        'camera/4.save_section2_details'
      when '3a'
        'ptw/camera/5.save_section3a_details'
      when '3b'
        'camera/6.save_section3b_details'
      when '4a'
        'camera/9.save_section4a_details'
      when '4ac'
        'ptw/camera/10.save_section4a_checklist_details'
      when '14'
        'camera/14.submit_for_master_approval'
      end
    when 'submit_enclose_space_entry'
      case _step
      when '0'
        'ptw/enclosed-workspace/0.create_form_ptw'
      when '00'
        'ptw/enclosed-workspace/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/enclosed-workspace/2.save_section0_details'
      when '3'
        'enclosed-workspace/3.save_section1_details'
      when '4'
        'enclosed-workspace/4.save_section2_details'
      when '3a'
        'ptw/enclosed-workspace/5.save_section3a_details'
      when '3b'
        'enclosed-workspace/6.save_section3b_details'
      when '4a'
        'enclosed-workspace/9.save_section4a_details'
      when '4ac'
        'ptw/enclosed-workspace/10.save_section4a_checklist_details'
      when '14'
        'enclosed-workspace/14.submit_for_master_approval'
      end
    when 'submit_cold_work_clean_spill'
      case _step
      when '0'
        'ptw/cold-work-cleaning-spill/0.create_form_ptw'
      when '00'
        'ptw/cold-work-cleaning-spill/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/cold-work-cleaning-spill/2.save_section0_details'
      when '3'
        'cold-work-cleaning-spill/3.save_section1_details'
      when '4'
        'cold-work-cleaning-spill/4.save_section2_details'
      when '3a'
        'ptw/cold-work-cleaning-spill/5.save_section3a_details'
      when '3b'
        'cold-work-cleaning-spill/6.save_section3b_details'
      when '4a'
        'cold-work-cleaning-spill/9.save_section4a_details'
      when '4ac'
        'ptw/cold-work-cleaning-spill/10.save_section4a_checklist_details'
      when '14'
        'cold-work-cleaning-spill/14.submit_for_master_approval'
      end
    when 'submit_hotwork'
      case _step
      when '0'
        'ptw/hotwork/0.create_form_ptw'
      when '00'
        'ptw/hotwork/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/hotwork/2.save_section0_details'
      when '3'
        'hotwork/3.save_section1_details'
      when '4'
        'hotwork/4.save_section2_details'
      when '3a'
        'ptw/hotwork/5.save_section3a_details'
      when '3b'
        'hotwork/6.save_section3b_details'
      when '4a'
        'hotwork/9.save_section4a_details'
      when '4ac'
        'ptw/hotwork/10.save_section4a_checklist_details'
      when '14'
        'hotwork/14.submit_for_master_approval'
      end
    when 'submit_underwater_simultaneous'
      case _step
      when '0'
        'ptw/underwater-sim/0.create_form_ptw'
      when '00'
        'ptw/underwater-sim/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/underwater-sim/2.save_section0_details'
      when '3'
        'underwater-sim/3.save_section1_details'
      when '4'
        'underwater-sim/4.save_section2_details'
      when '3a'
        'ptw/underwater-sim/5.save_section3a_details'
      when '3b'
        'underwater-sim/6.save_section3b_details'
      when '4a'
        'underwater-sim/9.save_section4a_details'
      when '4ac'
        'ptw/underwater-sim/10.save_section4a_checklist_details'
      when '14'
        'underwater-sim/14.submit_for_master_approval'
      end
    when 'submit_work_on_pressure_line'
      case _step
      when '0'
        'ptw/work-pressure-line/0.create_form_ptw'
      when '00'
        'ptw/work-pressure-line/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/work-pressure-line/2.save_section0_details'
      when '3'
        'work-pressure-line/3.save_section1_details'
      when '4'
        'work-pressure-line/4.save_section2_details'
      when '3a'
        'ptw/work-pressure-line/5.save_section3a_details'
      when '3b'
        'work-pressure-line/6.save_section3b_details'
      when '4a'
        'work-pressure-line/9.save_section4a_details'
      when '4ac'
        'ptw/work-pressure-line/10.save_section4a_checklist_details'
      when '14'
        'work-pressure-line/14.submit_for_master_approval'
      end
    when 'submit_maintenance_on_anchor'
      case _step
      when '0'
        'ptw/maintenance_on_anchor/0.create_form_ptw'
      when '00'
        'ptw/maintenance_on_anchor/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/maintenance_on_anchor/2.save_section0_details'
      when '3'
        'maintenance_on_anchor/3.save_section1_details'
      when '4'
        'maintenance_on_anchor/4.save_section2_details'
      when '3a'
        'ptw/maintenance_on_anchor/5.save_section3a_details'
      when '3b'
        'maintenance_on_anchor/6.save_section3b_details'
      when '4a'
        'maintenance_on_anchor/9.save_section4a_details'
      when '4ac'
        'ptw/maintenance_on_anchor/10.save_section4a_checklist_details'
      when '14'
        'maintenance_on_anchor/14.submit_for_master_approval'
      end
    when 'submit_rigging_of_ladder'
      case _step
      when '0'
        'ptw/rol/0.create_form_ptw'
      when '00'
        'ptw/rol/0.create_form_dra'
      when '1'
        'ptw/1.date_with_offset'
      when '2'
        'ptw/rol/2.save_rol_dra_section_details'
      when '3'
        'ptw/rol/3.save_rol_checklist_section_details'
      end
    end
  end
end
