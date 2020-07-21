# frozen_string_literal: true

require './././support/env'

class BypassPage
  include PageObject

  def trigger_forms_submission(_permit_type = nil, _user)
    ### init ptw form
    create_form_ptw = JSON.parse JsonUtil.read_json('ptw/0.create_form_ptw')
    create_form_ptw['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/0.mod_create_form_ptw', create_form_ptw)
    ServiceUtil.post_graph_ql('ptw/0.mod_create_form_ptw', _user)
    set_selected_permit(ServiceUtil.get_response_body['data']['createForm']['_id'])

    ### add time offset to ptw
    add_time_offset_to_ptw = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '1'))
    add_time_offset_to_ptw['variables']['id'] = get_selected_permit
    JsonUtil.create_request_file('ptw/1.mod_date_with_offset', add_time_offset_to_ptw)
    ServiceUtil.post_graph_ql('ptw/1.mod_date_with_offset', _user)
    get_offset = ServiceUtil.get_response_body['data']['form']['created']['utcOffset']

    ### init dra form
    init_dra = JSON.parse JsonUtil.read_json('ptw/0.create_form_dra')
    init_dra['variables']['parentFormId'] = get_selected_permit
    init_dra['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/0.mod_create_form_dra', init_dra)
    ServiceUtil.post_graph_ql('ptw/0.mod_create_form_dra', _user)
    dra_permit_number = ServiceUtil.get_response_body['data']['createForm']['_id']

    ### save section 0
    section2 = JSON.parse JsonUtil.read_json(payload_mapper(_permit_type, '2'))
    section2['variables']['formId'] = get_selected_permit
    section2['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_offset}}"
    section2['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_2.save_section0_details', section2)
    ServiceUtil.post_graph_ql('ptw/mod_2.save_section0_details', _user)

    ### save sections
    save_different_form_section(payload_mapper(_permit_type, '3'), _user)
    save_different_form_section(payload_mapper(_permit_type, '4'), _user)
    save_different_form_section(payload_mapper(_permit_type, '3a'), _user)
    save_different_form_section(payload_mapper(_permit_type, '3b'), _user)
    save_different_form_section('7.save_section3c_details', _user)
    save_different_form_section('8.save_section3d_details', _user)
    save_different_form_section(payload_mapper(_permit_type, '4a'), _user)
    save_different_form_section('10.save_section4a_ese_details', _user)

    # save_different_form_section('11.save_section4b_details', _user)
    ### save section 4b
    section2 = JSON.parse JsonUtil.read_json('ptw/11.save_section4b_details')
    section2['variables']['formId'] = get_selected_permit
    section2['variables']['answers'].last['value'] = "{\"dateTime\":\"#{get_current_date_time}\",\"utcOffset\":#{get_offset}}"
    section2['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file('ptw/mod_11.save_section4b_details', section2)
    ServiceUtil.post_graph_ql('ptw/mod_11.save_section4b_details', _user)

    save_different_form_section('12.save_section5_details', _user)
    save_different_form_section('13.save_section6_details', _user)
    ### submit
    save_different_form_section(payload_mapper(_permit_type, '14'), _user)
  end

  def get_selected_permit
    @@selected_level2_permit
  end

  private

  def set_selected_permit(_permit)
    @@selected_level2_permit = _permit
  end

  def save_different_form_section(_which_json, _user)
    section = JSON.parse JsonUtil.read_json("ptw/#{_which_json}")
    section['variables']['formId'] = get_selected_permit
    section['variables']['submissionTimestamp'] = get_current_date_time
    JsonUtil.create_request_file("ptw/mod#{_which_json.sub('/', '')}", section)
    ServiceUtil.post_graph_ql("ptw/mod#{_which_json.sub('/', '')}", _user)
  end

  def get_current_date_time
    DateTime.now.strftime('%Y-%m-%dT%H:%M:%S.901Z')
  end

  def payload_mapper(permit_name, _step)
    case permit_name
    when 'submit_non_intrinsical_camera'
      case _step
      when '1'
        'ptw/camera/1.date_with_offset'
      when '2'
        'ptw/camera/2.save_section0_details'
      when '3'
        'camera/3.save_section1_details'
      when '4'
        'camera/4.save_section2_details'
      when '3a'
        'camera/5.save_section3a_details'
      when '3b'
        'camera/6.save_section3b_details'
      when '4a'
        'camera/9.save_section4a_details'
      when '14'
        'camera/14.submit_for_master_approval'
      end
    when 'submit_enclose_space_entry'
      case _step
      when '1'
        'ptw/enclosed-workspace/1.date_with_offset'
      when '2'
        'ptw/enclosed-workspace/2.save_section0_details'
      when '3'
        'enclosed-workspace/3.save_section1_details'
      when '4'
        'enclosed-workspace/4.save_section2_details'
      when '3a'
        'enclosed-workspace/5.save_section3a_details'
      when '3b'
        'enclosed-workspace/6.save_section3b_details'
      when '4a'
        'enclosed-workspace/9.save_section4a_details'
      when '14'
        'enclosed-workspace/14.submit_for_master_approval'
      end
    end
  end
end
