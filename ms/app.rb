require 'sinatra'
require 'sinatra/cross_origin'
require 'sinatra/reloader'
require_relative 'ms_util'
require_relative 'operation_name_const'

class MockServerApp < Sinatra::Base 
	include OperationNameConstant
	include MSUtil
	
	configure do
    register Sinatra::Reloader
    register Sinatra::CrossOrigin
    enable :cross_origin
    set :allow_origin, :any
    # set :allow_methods, %i[get post options head put patch delete]
    # set :allow_credentials, true
    # set :max_age, '1728000'
    # set :expose_headers, ['Content-Type']
	end
	
	options '*' do
		response.headers['Access-Control-Allow-Methods'] = 'GET,HEAD,PUT,POST,DELETE,PATCH'
    response.headers['Access-Control-Allow-Headers'] = 'content-type'
    # puts ">>>>>>>>>>> " + request.url.to_s
    # puts ">>>>>>>>>>> " + request.request_method.to_s
    204
	end
	
	post '/' do
		request_body = JSON.parse request.body.read
		puts request_body.size
		if (request_body.size.to_s === '2') && (request_body[0]['query'].include? CREW_LIST)# && (request_body[1]['query'].include? CREW_LIST)
			puts ">>>>>>>>>>>>>>>>>>>>>>>> " + request_body[0]['query'] + " <<<<<<<<<<<<<<<<<<<<<<<<<<"
			json_response 200, 'crew_list/crew_list.json'
		elsif (request_body.size.to_s === '3') && (request_body[2]['query'].include? '{\n  vessel {')
			puts ">>>IN<<<"
			json_response 200, 'crew_list/crew_with_vessel_list.json'
		elsif request_body[0]['query'].include? "fragment zoneFragment on Zone {"
			json_response 200, 'crew_list/map.json'
		elsif request_body[0]['query'].include? "\n  currentTime {"
			json_response 200, 'crew_list/current_time.json'
		else
			400
		end
	end
	
	def json_response(response_code, file_name)
		content_type 'application/json'
		status "#{response_code}"
		puts "response code>> #{response_code}"
		puts "file name>> " +  File.expand_path("../mock/#{file_name}",__FILE__)
		File.open(File.expand_path("../mock/#{file_name}",__FILE__)).read
	end
end
