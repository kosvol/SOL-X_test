# frozen_string_literal: true

class WorkResetrHoursPage
  class << self
    def load_work_rest_hour
      tmp_payload = JSON.parse JsonUtil.read_json('wrh/work-rest-hour')
      tmp_payload['docs'].each_with_index do |_doc, _index|
        userid = _doc['userId']
        userid[0, 4] = 'SIT' if $current_environment == 'sit'
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
      ttt[0, 13] =
        "#{(Date.today - 1).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
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
      ttt[0, 13] =
        "#{(Date.today - 2).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-1).strftime("%Y-%m-%d")
      tmp_payload['docs'][26]['endTime'] = ttt

      ttt = tmp_payload['docs'][27]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 4).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][27]['startTime'] = ttt
      ttt = tmp_payload['docs'][27]['endTime']
      ttt[0, 13] =
        "#{(Date.today - 3).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-2).strftime("%Y-%m-%d")
      tmp_payload['docs'][27]['endTime'] = ttt

      ttt = tmp_payload['docs'][28]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 5).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][28]['startTime'] = ttt
      ttt = tmp_payload['docs'][28]['endTime']
      ttt[0, 13] =
        "#{(Date.today - 4).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-3).strftime("%Y-%m-%d")
      tmp_payload['docs'][28]['endTime'] = ttt

      ttt = tmp_payload['docs'][29]['startTime']
      ttt[0, 13] =
        "#{(Date.today - 6).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(-24, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-4).strftime("%Y-%m-%d")
      tmp_payload['docs'][29]['startTime'] = ttt
      ttt = tmp_payload['docs'][29]['endTime']
      ttt[0, 13] =
        "#{(Date.today - 5).strftime('%Y-%m-%d')}T#{DateTime.now.new_offset(Rational(0, 24)).strftime('%H')}"
      # ttt[0,10] = (Date.today-4).strftime("%Y-%m-%d")
      tmp_payload['docs'][29]['endTime'] = ttt

      JsonUtil.create_request_file('wrh/mod-wrk-rest-hr', tmp_payload)
      ServiceUtil.fauxton(EnvironmentSelector.get_db_url('fauxton_url', 'add-work-rest-hour'), 'post',
                          'wrh/mod-wrk-rest-hr')
    end
  end
end
