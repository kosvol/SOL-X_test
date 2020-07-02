# frozen_string_literal: true

require 'httparty'
require 'fileutils'

module ServiceUtil
  include HTTParty
  class << self
    def post_graph_ql(which_json, _user)
      uri = EnvironmentSelector.get_graphql_environment_url('service')
      content_body = JsonUtil.read_json(which_json)
      error_logging('URI: ', uri)
      error_logging('Request Body: ', content_body)
      @@response = HTTParty.post(uri, { body: content_body }.merge(ql_headers(_user)))
      error_logging('Response Body: ', @@response)
      error_logging('Status Code: ', get_http_response_status_code)
      JsonUtil.create_response_file(which_json, @@response, get_http_response_status_code)
    end

    def fauxton(_uri, _trans_method, _json_payload)
      content_body = JsonUtil.read_json(_json_payload)
      error_logging('URI: ', _uri)
      error_logging('Request Body: ', content_body)
      if _trans_method === 'post'
        @@response = HTTParty.post(_uri, { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      if _trans_method === 'get'
        @@response = HTTParty.get(_uri, { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      if _trans_method === 'delete'
        @@response = HTTParty.delete(_uri, { body: content_body }.merge({ headers: { 'Content-Type' => 'application/json' } }))
      end
      error_logging('Response Body: ', @@response)
      error_logging('Status Code: ', get_http_response_status_code)
      JsonUtil.create_response_file(_json_payload, @@response, get_http_response_status_code)
    end

    def get_error_code
      # init error code mapping
      $error_code_yml = YAML.load_file('data/error_code.yml')
      get_response_body['errors'].first['extensions']['code'].to_s
    end

    def get_response_body
      @@response if !@@response.body.nil? && !@@response.body.empty?
    end

    private

    def ql_headers(authorization_pin)
      { headers: {
        'Content-Type' => 'application/json',
        'Accept' => '/',
        'x-auth-pin' => authorization_pin
      } }
    end

    def error_logging(header, values = nil)
      Log.instance.info('')
      Log.instance.info("\n\n#{header} #{values}\n\n")
      Log.instance.info('')
      self
    end

    def get_http_response_status_code
      @@response.code.to_i if !@@response.body.nil? && !@@response.body.empty?
    end
  end
end
