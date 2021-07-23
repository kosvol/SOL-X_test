# frozen_string_literal: true

class SmartFormDBPage
  class << self
    def tear_down_ptw_form(_form_id)
      rev_tag = ''
      ServiceUtil.fauxton(get_environment_link('fauxton', 'get_forms'), 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['rows'].each do |form|
        if form['id'] === _form_id && (!form['id'].include? '_design')
          rev_tag = form['value']['rev']
          break
        end
      end
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      tmp_payload['docs'][0]['_id'] = _form_id
      tmp_payload['docs'][0]['_rev'] = rev_tag
      JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
      ServiceUtil.fauxton(get_environment_link('fauxton', 'delete_form'), 'post', 'fauxton/delete_form')
    end

    def load_work_rest_hour
      tmp_payload = JSON.parse JsonUtil.read_json('wrh/work-rest-hour')
      tmp_payload['docs'].each_with_index do |_doc, _index|
        userid = _doc['userId']
        userid[0, 4] = 'SIT' if $current_environment === 'sit'
        tmp_payload['docs'][_index]['userId'] = userid
      end

      # ## 13h59m SOLX0004
      ttt = tmp_payload['docs'][0]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-7, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][0]['startTime'] = ttt
      ttt = tmp_payload['docs'][0]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][0]['endTime'] = ttt

      ttt = tmp_payload['docs'][1]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-10, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][1]['startTime'] = ttt
      ttt = tmp_payload['docs'][1]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-7, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][1]['endTime'] = ttt

      ttt = tmp_payload['docs'][2]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-13, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-13, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-13, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-13, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][2]['startTime'] = ttt
      ttt = tmp_payload['docs'][2]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-10, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][2]['endTime'] = ttt

      # ## 9h59m _SOLX0005
      ttt = tmp_payload['docs'][3]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-7, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][3]['startTime'] = ttt
      ttt = tmp_payload['docs'][3]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][3]['endTime'] = ttt

      ttt = tmp_payload['docs'][4]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-10, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-10, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][4]['startTime'] = ttt
      ttt = tmp_payload['docs'][4]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-7, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][4]['endTime'] = ttt

      # ## 71h59m SOLX0006
      ttt = tmp_payload['docs'][5]['startTime']
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-12, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-12, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-12, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-12, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][5]['startTime'] = ttt
      ttt = tmp_payload['docs'][5]['endTime']
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      tmp_payload['docs'][5]['endTime'] = ttt

      ttt = tmp_payload['docs'][6]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-13, 24)).strftime('%H')}"
      tmp_payload['docs'][6]['startTime'] = ttt
      ttt = tmp_payload['docs'][6]['endTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-12, 24)).strftime('%H')}"
      tmp_payload['docs'][6]['endTime'] = ttt

      ttt = tmp_payload['docs'][7]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-14, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][7]['startTime'] = ttt
      ttt = tmp_payload['docs'][7]['endTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-13, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][7]['endTime'] = ttt

      ttt = tmp_payload['docs'][8]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-15, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][8]['startTime'] = ttt
      ttt = tmp_payload['docs'][8]['endTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-14, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][8]['endTime'] = ttt

      ttt = tmp_payload['docs'][9]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 2).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-17, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][9]['startTime'] = ttt
      ttt = tmp_payload['docs'][9]['endTime']
      ttt[0, 13] = "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][9]['endTime'] = ttt

      ttt = tmp_payload['docs'][10]['startTime']
      ttt[0, 10] = (Date.today - 3).strftime('%Y-%m-%d')
      tmp_payload['docs'][10]['startTime'] = ttt
      ttt = tmp_payload['docs'][10]['endTime']
      ttt[0, 10] = (Date.today - 3).strftime('%Y-%m-%d')
      tmp_payload['docs'][10]['endTime'] = ttt

      ttt = tmp_payload['docs'][11]['startTime']
      ttt[0, 10] = (Date.today - 3).strftime('%Y-%m-%d')
      tmp_payload['docs'][11]['startTime'] = ttt
      ttt = tmp_payload['docs'][11]['endTime']
      ttt[0, 10] = (Date.today - 3).strftime('%Y-%m-%d')
      tmp_payload['docs'][11]['endTime'] = ttt

      ttt = tmp_payload['docs'][12]['startTime']
      ttt[0, 10] = (Date.today - 3).strftime('%Y-%m-%d')
      tmp_payload['docs'][12]['startTime'] = ttt
      ttt = tmp_payload['docs'][12]['endTime']
      ttt[0, 10] = (Date.today - 3).strftime('%Y-%m-%d')
      tmp_payload['docs'][12]['endTime'] = ttt

      ttt = tmp_payload['docs'][13]['startTime']
      ttt[0, 10] = (Date.today - 4).strftime('%Y-%m-%d')
      tmp_payload['docs'][13]['startTime'] = ttt
      ttt = tmp_payload['docs'][13]['endTime']
      ttt[0, 10] = (Date.today - 4).strftime('%Y-%m-%d')
      tmp_payload['docs'][13]['endTime'] = ttt

      ttt = tmp_payload['docs'][14]['startTime']
      ttt[0, 10] = (Date.today - 5).strftime('%Y-%m-%d')
      tmp_payload['docs'][14]['startTime'] = ttt
      ttt = tmp_payload['docs'][14]['endTime']
      ttt[0, 10] = (Date.today - 5).strftime('%Y-%m-%d')
      tmp_payload['docs'][14]['endTime'] = ttt

      ### AUTO_SOLX0007
      ttt = tmp_payload['docs'][15]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-3, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][15]['startTime'] = ttt
      ttt = tmp_payload['docs'][15]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][15]['endTime'] = ttt

      ttt = tmp_payload['docs'][16]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-6, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][16]['startTime'] = ttt
      ttt = tmp_payload['docs'][16]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-3, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][16]['endTime'] = ttt

      ### AUTO_SOLX0013
      ttt = tmp_payload['docs'][17]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-4, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-4, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-4, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-4, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][17]['startTime'] = ttt
      ttt = tmp_payload['docs'][17]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][17]['endTime'] = ttt

      ttt = tmp_payload['docs'][18]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-8, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][18]['startTime'] = ttt
      ttt = tmp_payload['docs'][18]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-4, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-4, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-4, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-4, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][18]['endTime'] = ttt

      ttt = tmp_payload['docs'][19]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-11, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-11, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-11, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-11, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][19]['startTime'] = ttt
      ttt = tmp_payload['docs'][19]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-8, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = (Date.today+1).strftime("%Y-%m-%d")
      tmp_payload['docs'][19]['endTime'] = ttt

      ### AUTO_SOLX0009
      ttt = tmp_payload['docs'][20]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-2, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-2, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-2, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-2, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['startTime'] = ttt
      ttt = tmp_payload['docs'][20]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][20]['endTime'] = ttt

      ttt = tmp_payload['docs'][21]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-5, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-5, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-5, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-5, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][21]['startTime'] = ttt
      ttt = tmp_payload['docs'][21]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-3, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-3, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][21]['endTime'] = ttt

      ttt = tmp_payload['docs'][22]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-8, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-8, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][22]['startTime'] = ttt
      ttt = tmp_payload['docs'][22]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-7, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-7, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][22]['endTime'] = ttt

      ttt = tmp_payload['docs'][23]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-11, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-11, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-11, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-11, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][23]['startTime'] = ttt
      ttt = tmp_payload['docs'][23]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-9, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-9, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-9, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-9, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = (Date.today+1).strftime("%Y-%m-%d")
      tmp_payload['docs'][23]['endTime'] = ttt

      ### AUTO_SOLX0012
      ttt = tmp_payload['docs'][24]['startTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-6, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][24]['startTime'] = ttt
      ttt = tmp_payload['docs'][24]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(0, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(0, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][24]['endTime'] = ttt

      ttt = tmp_payload['docs'][25]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-14, 24)).strftime('%H')}"
      # ttt[0,24] = ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-20, 24)).strftime('%Y').to_i,DateTime.now.new_offset(Rational(-20, 24)).strftime('%m').to_i,DateTime.now.new_offset(Rational(-14, 24)).strftime('%d').to_i,DateTime.now.new_offset(Rational(-14, 24)).strftime('%H').to_i,0,0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][25]['startTime'] = ttt
      ttt = tmp_payload['docs'][25]['endTime']
      ttt[0, 24] =
        ServiceUtil.craft_date_time_format(DateTime.now.new_offset(Rational(-6, 24)).strftime('%Y').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%m').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%d').to_i, DateTime.now.new_offset(Rational(-6, 24)).strftime('%H').to_i, 0, 0)
      # ttt[0,10] = Date.today.strftime("%Y-%m-%d")
      tmp_payload['docs'][25]['endTime'] = ttt

      ttt = tmp_payload['docs'][26]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 3).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][26]['startTime'] = ttt
      ttt = tmp_payload['docs'][26]['endTime']
      ttt[0, 13] = "#{(Date.today - 2).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][26]['endTime'] = ttt

      ttt = tmp_payload['docs'][27]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 4).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][27]['startTime'] = ttt
      ttt = tmp_payload['docs'][27]['endTime']
      ttt[0, 13] = "#{(Date.today - 3).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][27]['endTime'] = ttt

      ttt = tmp_payload['docs'][28]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 5).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][28]['startTime'] = ttt
      ttt = tmp_payload['docs'][28]['endTime']
      ttt[0, 13] = "#{(Date.today - 4).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][28]['endTime'] = ttt

      ttt = tmp_payload['docs'][29]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 6).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-4).strftime("%Y-%m-%d")
      tmp_payload['docs'][29]['startTime'] = ttt
      ttt = tmp_payload['docs'][29]['endTime']
      ttt[0, 13] = "#{(Date.today - 5).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-4).strftime("%Y-%m-%d")
      tmp_payload['docs'][29]['endTime'] = ttt

      JsonUtil.create_request_file('wrh/mod-wrk-rest-hr', tmp_payload)
      ServiceUtil.fauxton(get_environment_link('fauxton', 'add-work-rest-hour'), 'post', 'wrh/mod-wrk-rest-hr')
    end

    def get_table_data(_which_db, _url_map)
      ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'get', 'fauxton/get_forms')
    end

    def delete_table_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if form['id'].include? '_design'

        if ((($current_environment.include? 'auto')&&(form['id'].include? 'AUTO')) || (($current_environment.include? 'sit')&&(form['id'].include? 'SIT')))
          tmp_payload['docs'][0]['_id'] = form['id']
          tmp_payload['docs'][0]['_rev'] = form['value']['rev']
          JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
          ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
        end
      end
    end

    def delete_geofence_row(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if (form['id'].include? '_design')# || (form['id'].include? 'UAT') || (form['id'].include? 'DEV') || (form['id'].include? 'LNGDEV') || (form['id'].include? 'LNGUAT')
        if ((($current_environment.include? 'auto')&&(form['id'].include? 'AUTO')) || (($current_environment.include? 'sit')&&(form['id'].include? 'SIT')))
          tmp_payload['docs'][0]['_id'] = form['id']
          tmp_payload['docs'][0]['_rev'] = form['value']['rev']
          JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
          ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
        end
        # tmp_payload['docs'][0]['_id'] = form['id']
        # tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        # JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        # ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    def delete_crew_from_vessel(_which_db, _url_map)
      tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
      ServiceUtil.get_response_body['rows'].each do |form|
        next if (form['id'].include? '_design') || (form['id'].include? 'SIT') || (form['id'].include? 'AUTO')

        tmp_payload['docs'][0]['_id'] = form['id']
        tmp_payload['docs'][0]['_rev'] = form['value']['rev']
        JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
        ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
      end
    end

    # def delete_pre_table_row(_which_db, _url_map)
    #   tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
    #   ServiceUtil.get_response_body['rows'].each do |form|
    #     if (form['id'].include? '_design') || (form['id'].include? 'UAT') || (form['id'].include? 'PTW') || (form['id'].include? 'DRA') || (form['id'].include? 'EIC')
    #       next
    #     end

    #     tmp_payload['docs'][0]['_id'] = form['id']
    #     tmp_payload['docs'][0]['_rev'] = form['value']['rev']
    #     JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
    #     ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
    #   end
    # end

    # def delete_oa_table_row(_which_db, _url_map)
    #   tmp_payload = JSON.parse JsonUtil.read_json('fauxton/delete_form')
    #   ServiceUtil.get_response_body['rows'].each do |form|
    #     next if ((form['id'].include? '_design') || (form['id'].include? 'DEV') || (form['id'].include? 'LNGDEV') || (form['id'].include? 'UAT'))# || (form['id'].include? 'SIT'))

    #     tmp_payload['docs'][0]['_id'] = form['id']
    #     tmp_payload['docs'][0]['_rev'] = form['value']['rev']
    #     JsonUtil.create_request_file('fauxton/delete_form', tmp_payload)
    #     ServiceUtil.fauxton(get_environment_link(_which_db.to_s, _url_map.to_s), 'post', 'fauxton/delete_form')
    #   end
    # end

    def acknowledge_pre_entry_log
      entry_id = get_pre_gas_entry_log_id('fauxton', 'get_pre_gas_entry_log', get_mod_permit_id)
      acknowledge_entry_log_payload = JSON.parse JsonUtil.read_json('pre/02.acknowledge-entry-log')
      acknowledge_entry_log_payload['variables']['formId'] = @@pre_number
      acknowledge_entry_log_payload['variables']['entryId'] = entry_id
      JsonUtil.create_request_file('pre/mod_02.acknowledge-entry-log', acknowledge_entry_log_payload)
      ServiceUtil.post_graph_ql('pre/mod_02.acknowledge-entry-log', '8383')
    end

    def get_error_message
      ServiceUtil.get_response_body['errors'].first['message']
    end

    private

    # def craft_date_time_format(_year,_month,_day,_hour,_min,_seconds)
    #   DateTime.new(_year,_month,_day,_hour,_min,_seconds).strftime("%d-%b-%YT:%H:%M:%S.%LZ")
    # end

    def get_date_time_with_offset(_offset)
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

    def get_mod_permit_id
      @@pre_number.gsub('/', '%2F')
    end

    def get_pre_gas_entry_log_id(_which_db, _url_map, _which_pre_entry_log)
      _uri = get_environment_link(_which_db.to_s, _url_map.to_s)
      _uri = format(_uri, _which_pre_entry_log)
      p "URI: #{_uri}"
      ServiceUtil.fauxton(_uri, 'get', 'fauxton/get_forms')
      ServiceUtil.get_response_body['records'].first['entryId']
    end

    def get_environment_link(_which_db, _url_map)
      if $current_environment === 'sit' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'dev' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_dev_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'auto' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_auto_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif $current_environment === 'uat' && _which_db != 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_uat_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      elsif _which_db === 'oa_db'
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      # elsif ENV['env'] === 'ngrok'
      #   'http://d0b02eada7fb.ngrok.io/' + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      else
        $obj_env_yml[_which_db.to_s]['base_sit_url'] + $obj_env_yml[_which_db.to_s][_url_map.to_s]
      end
    end
  end
end
