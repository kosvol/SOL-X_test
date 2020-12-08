# frozen_string_literal: true

require './././support/env'

class BypassPage < Section0Page
  include PageObject

  def trigger_pre_submission(_user)
    create_form_pre = JSON.parse JsonUtil.read_json('pre/01.create-pre-form')
    create_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('pre/mod-01.create-pre-form', create_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-01.create-pre-form', _user)
    CommonPage.set_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ServiceUtil.post_graph_ql('ship-local-time/base-get-current-time', _user)
    @get_offset = ServiceUtil.get_response_body['data']['currentTime']['utcOffset']
    update_form_pre = JSON.parse JsonUtil.read_json('pre/02.update-form-answers')
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['answers'][25]['value'] = "{\"dateTime\":\"#{get_current_minutes_time_with_offset}\",\"utcOffset\":#{@get_offset}}"
    update_form_pre['variables']['answers'][26]['value'] = "{\"dateTime\":\"#{get_current_hours_time_with_offset(@get_offset)}\",\"utcOffset\":#{@get_offset}}"
    JsonUtil.create_request_file('pre/mod-02.update-form-answers', update_form_pre)
    ServiceUtil.post_graph_ql('pre/mod-02.update-form-answers', _user)

    update_form_pre = JSON.parse JsonUtil.read_json('pre/03.update-form-status')
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/03.update-form-status', update_form_pre)
    ServiceUtil.post_graph_ql('pre/03.update-form-status', _user)

    update_form_pre = JSON.parse JsonUtil.read_json('pre/04.update-form-status')
    update_form_pre['variables']['submissionTimestamp'] = get_current_date_time
    update_form_pre['variables']['formId'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('pre/04.update-form-status', update_form_pre)
    ServiceUtil.post_graph_ql('pre/04.update-form-status', _user)
  end

  def trigger_forms_submission(_permit_type = nil, _user, _state, eic, _gas)
    @via_service_or_not = true
    ### init ptw form
    create_form_ptw = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '0'))
    create_form_ptw['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/0.mod_create_form_ptw', create_form_ptw)
    ServiceUtil.post_graph_ql('ptw/0.mod_create_form_ptw', _user)
    CommonPage.set_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ### add time offset to ptw
    add_time_offset_to_ptw = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '1'))
    add_time_offset_to_ptw['variables']['id'] = CommonPage.get_permit_id
    JsonUtil.create_request_file('ptw/1.mod_date_with_offset', add_time_offset_to_ptw)
    ServiceUtil.post_graph_ql('ptw/1.mod_date_with_offset', _user)
    @get_offset = ServiceUtil.get_response_body['data']['form']['created']['utcOffset']

    ### init dra form
    init_dra = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '00'))
    init_dra['variables']['parentFormId'] = CommonPage.get_permit_id
    init_dra['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/0.mod_create_form_dra', init_dra)
    ServiceUtil.post_graph_ql('ptw/0.mod_create_form_dra', _user)
    CommonPage.set_dra_permit_id(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ### save section 0
    # section2 = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '2'))
    # section2['variables']['formId'] = CommonPage.get_permit_id
    # section2['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
    # section2['variables']['submissionTimestamp'] = get_current_date_time
    # JsonUtil.create_request_file('ptw/mod_2.save_section0_details', section2)
    # ServiceUtil.post_graph_ql('ptw/mod_2.save_section0_details', _user)

    ### save sections
    save_different_form_section(payload_mapper(_permit_type, '3'), _user)
    save_different_form_section(payload_mapper(_permit_type, '4'), _user)

    ### section 3a ###
    section3a = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '3a'))
    section3a['variables']['formId'] = CommonPage.get_permit_id
    # section3a['variables']['answers'][3]['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
    section3a['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_5.save_section3a_details', section3a)
    ServiceUtil.post_graph_ql('ptw/mod_5.save_section3a_details', _user)
    ### end ###

    save_different_form_section(payload_mapper(_permit_type, '3b'), _user)
    save_different_form_section('7.save_section3c_details', _user)
    save_different_form_section('8.save_section3d_details', _user)
    save_different_form_section(payload_mapper(_permit_type, '4a'), _user)

    ### section 4ac ###
    section4ac = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '4ac'))
    section4ac['variables']['formId'] = CommonPage.get_permit_id
    section4ac['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_10.save_section4a_checklist_details', section4ac)
    ServiceUtil.post_graph_ql('ptw/mod_10.save_section4a_checklist_details', _user)

    ### section 4b ###
    section4b = JSON.parse JsonUtil.read_json('ptw/11.save_section4b_details')
    section4b['variables']['formId'] = CommonPage.get_permit_id
    section4b['variables']['submissionTimestamp'] = get_current_date_time
    if eic === 'eic_yes'
      section4b['variables']['answers'][1].to_h['value'] = '"yes"'
      section4b['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
    elsif eic === 'eic_no'
      section4b['variables']['answers'][1].to_h['value'] = '"no"'
      section4b['variables']['answers'].pop
    end
    JsonUtil.create_request_file('ptw/mod_11.save_section4b_details', section4b)
    ServiceUtil.post_graph_ql('ptw/mod_11.save_section4b_details', _user)
    ### end ###

    save_different_form_section('12.save_section5_details', _user)

    ### section 6 ###
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
    _update_permit['variables']['answers'][3].to_h['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{@get_offset}}"
    if _permit_type != 'submit_underwater_simultaneou'
      _update_permit['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time_cal(8)}\",\"utcOffset\":#{@get_offset}}"
    else
      _update_permit['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time_cal(4)}\",\"utcOffset\":#{@get_offset}}"
    end
    JsonUtil.create_request_file('ptw/mod_16.update-active-status', _update_permit)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status', _user)
  end

  def set_permit_status(_status)
    submit_status = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_status['variables']['newStatus'] = _status
    submit_status
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
    url = "https://admin:magellanx@cloud-edge.stage.solas.magellanx.io:5984/forms/#{CommonPage.get_permit_id.gsub('/', '%2F')}?conflicts=true"
    ServiceUtil.fauxton(url, 'get')
    permit_payload = JSON.parse ServiceUtil.get_response_body.to_s
    permit_payload['status'] = status
    ServiceUtil.fauxton(url, 'put', permit_payload.to_json)

    submit_active = JSON.parse JsonUtil.read_json('ptw/16.update-active-status')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    submit_active['variables']['answers'][3].to_h['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time_cal(8)}\",\"utcOffset\":#{get_current_time_offset}}"
    JsonUtil.create_request_file('ptw/mod_16.update-active-status', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status')
  end

  def set_non_oa_permit_to_active_state
    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    set_current_time
    reset_data_collector
    @@created_permit_data = set_section1_filled_data
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')

    submit_active = JSON.parse JsonUtil.read_json('ptw/16.update-active-status')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    submit_active['variables']['answers'][3].to_h['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time_cal(2)}\",\"utcOffset\":#{get_current_time_offset}}"
    JsonUtil.create_request_file('ptw/mod_16.update-active-status', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_16.update-active-status')
  end

  def set_rol_to_active(_duration)
    submit_active = JSON.parse JsonUtil.read_json('ptw/15.submit-to-active')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_15.submit-to-active', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod_15.submit-to-active')

    submit_active = JSON.parse JsonUtil.read_json('ptw/rol/approve-rol')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['answers'][5].to_h['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'][6].to_h['value'] = "\"#{_duration}\""
    submit_active['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time_cal(_duration)}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod-approve-rol', submit_active)
    ServiceUtil.post_graph_ql('ptw/mod-approve-rol')
  end

  def submit_permit_for_termination_wo_eic_normalization(_status)
    submit_active = JSON.parse JsonUtil.read_json('ptw/17.submit-for-termination-wo-eic-normalization')
    submit_active['variables']['formId'] = CommonPage.get_permit_id
    submit_active['variables']['answers'][1].to_h['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_current_time_offset}}"
    submit_active['variables']['answers'][3].to_h['value'] = "\"#{_status}\""
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

  private

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

  def cal_new_minutes_offset_time
    @current_minute = Time.now.utc.strftime('%M')
    current_minute = @current_minute.to_i + 2
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
    Time.now.utc.strftime("%Y-%m-%dT#{cal_new_hour_offset_time(_offset)}:%M:%S.901Z")
  end

  def get_current_minutes_time_with_offset
    Time.now.utc.strftime("%Y-%m-%dT%H:#{cal_new_minutes_offset_time}:%S.901Z")
  end

  def get_current_date_time
    Time.now.utc.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  def get_issued_time
    @@issued_time = Time.now.utc.strftime('H:%M')
  end

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
        'ptw/camera/1.date_with_offset'
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
        'ptw/enclosed-workspace/1.date_with_offset'
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
        'ptw/cold-work-cleaning-spill/1.date_with_offset'
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
        'ptw/hotwork/1.date_with_offset'
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
        'ptw/underwater-sim/1.date_with_offset'
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
        'ptw/work-pressure-line/1.date_with_offset'
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
    end
  end
end
