# frozen_string_literal: true

require 'httparty'
require 'fileutils'
require 'date'

module ServiceUtil
  include HTTParty
  class << self
    def update_crew_members_vessel(vesselType, regex)
      uri = EnvironmentSelector.get_edge_db_data_by_uri('crew_members/_find')
      content_body = JSON.parse JsonUtil.read_json('vessel-switch/get_crew_members')
      content_body['selector']['_id']['$regex'] = regex
      error_logging('URI: ', uri)
      error_logging('Request Body: ', content_body)
      @response = ServiceUtil.fauxton(uri, 'post', content_body.to_json.to_s)
      error_logging('Response Body: ', @response)

      crew_members = JSON.parse @response.to_s
      crew_members['docs'].each do |crew|
        crew['vesselId'] = vesselType
      end
      error_logging('Request Body: ', crew_members)
      uri = EnvironmentSelector.get_edge_db_data_by_uri('crew_members/_bulk_docs')
      @response = ServiceUtil.fauxton(uri, 'post', crew_members.to_json)
      error_logging('Response Body: ', @response)
    end

    def post_graph_ql_to_uri(which_json, _user = '1111', _uri)
      uri = EnvironmentSelector.get_service_url
      content_body = JsonUtil.read_json(which_json)
      error_logging('URI: ', uri)
      error_logging('Request Body: ', content_body)
      @response = HTTParty.post(uri, { body: content_body }.merge(ql_headers(_user)))
      error_logging('Response Body: ', @response)
      error_logging('Status Code: ', get_http_response_status_code)
      JsonUtil.create_response_file(which_json, @response, get_http_response_status_code)
    end

    # def switch_vessel_type(_vesselType, _user = '1111')
    #   uri = EnvironmentSelector.get_vessel_switch_url
    #   if $current_environment === 'auto'
    #     content_body = JsonUtil.read_json('vessel-switch/get_auto_vessel_details')
    #   elsif $current_environment === 'sit'
    #     content_body = JsonUtil.read_json('vessel-switch/get_sit_vessel_details')
    #   end
    #   error_logging('URI: ', uri)
    #   error_logging('Request Body: ', content_body)
    #   @response = HTTParty.get(uri, { body: content_body }.merge(ql_headers('_user')))
    #   error_logging('Response Body: ', @response)

    #   vessel_details = JSON.parse response.to_s
    #   vessel_details['vesselType'] = _vesselType.upcase
    #   p "> #{vessel_details.to_json}"
    #   @response = HTTParty.put(uri, { body: vessel_details.to_json }.merge(ql_headers('_user')))
    #   error_logging('Switch Response Body: ', @response)
    # end

    def post_graph_ql(which_json, _user = '1111')
      uri = EnvironmentSelector.get_service_url
      content_body = JsonUtil.read_json(which_json)
      error_logging('URI: ', uri)
      error_logging('Request Body: ', content_body)
      @response = HTTParty.post(uri, { body: content_body }.merge(ql_headers(_user)))
      error_logging('Response Body: ', @response)
      error_logging('Status Code: ', get_http_response_status_code)
      JsonUtil.create_response_file(which_json, @response, get_http_response_status_code)
    end

    def fauxton(_uri, _trans_method, _json_payload = '')
      content_body = _json_payload
      # switch
      content_body = JsonUtil.read_json(_json_payload) if _json_payload != '' && _json_payload.size < 20
      error_logging('URI: ', _uri)
      error_logging('Request Body: ', content_body)
      if _trans_method === 'put'
        @response = HTTParty.put(_uri,
                                 { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      if _trans_method === 'post'
        @response = HTTParty.post(_uri,
                                  { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      if _trans_method === 'get'
        @response = HTTParty.get(_uri,
                                 { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      if _trans_method === 'delete'
        @response = HTTParty.delete(_uri,
                                    { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      error_logging('Response Body: ', @response)
      error_logging('Status Code: ', get_http_response_status_code)
      unless _json_payload.include? '{'
        JsonUtil.create_response_file(_json_payload, @response, get_http_response_status_code)
      end
      @response
    end

    def get_error_code
      # init error code mapping
      $error_code_yml = YAML.load_file('data/error_code.yml')
      get_response_body['errors'].first['extensions']['code'].to_s
    end

    def get_response_body
      @response if !@response.body.nil? && !@response.body.empty?
    end

    def craft_date_time_format(_year, _month, _day, _hour, _min, _seconds)
      DateTime.new(_year, _month, _day, _hour, _min, _seconds).strftime('%Y-%m-%dT%H:%M:%S.%LZ')
    end

    private

    def ql_headers(authorization_pin)
      { headers: {
        'Content-Type' => 'application/json',
        'Accept' => '/',
        'x-auth-pin' => authorization_pin,
        'x-auth-user' => 'system',
      } }
    end

    def error_logging(header, values = nil)
      Log.instance.info('')
      Log.instance.info("\n\n#{header} #{values.to_s.encode('utf-8', invalid: :replace, undef: :replace,
                                                                     replace: '_')}\n\n")
      Log.instance.info('')
      self
    end

    def get_http_response_status_code
      @response.code.to_i if !@response.body.nil? && !@response.body.empty?
    end
  end
end
