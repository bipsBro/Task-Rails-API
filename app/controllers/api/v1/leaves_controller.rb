require 'uri'
require 'net/http'
require 'net/https'
require 'json'
module Api
	module V1
		class LeavesController < ApplicationController
			
			# include ActionController::HttpAuthentication::Basic::ControllerMethods
			# http_basic_authenticate_with name: "name", password: "password", except: [:index, :show]

			def index
				response = notify_slack("#test", "bipin", "hello bro", "image")
				body = response.body

				render json: body
				# articles = Leave.order('created_at DESC');
				# render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status: :ok
			end

			def show
				articles = Leave.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status: :ok
			end
			# POST /leaves
			def create
				leave = Leave.new(leave_params)
				if leave.save
					render json: {status: 'SUCCESS', message: 'Saved article', data:leave}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Not saved', data:leave.errors}, status: :unprocessable_entry
				end
			end

			private
				# Only allow a trusted parameter "white list" through.
			    def leave_params
			      	params.permit(:date, :leavetype, :reason)
			    end
				def token
					
				end
				def post_message
				end

				def get_oauth_access

				end
				def notify_slack(channel, username, text, image)
				  	url = URI.parse('https://slack.com/api/chat.postMessage')
				
					header = {
						'Content-Type' => 'application/json',
						'Authorization' => 'Bearer xoxp-386081642915-386325551061-387037431282-0d142cee6487ae8a082fe30e1119ab3c'
					}
					payload = {
					    "channel" => channel,
					    "text" => text,
					    # "icon_emoji" => ''
					    "as_user" => false,
					    "username" => username
					}
					http = Net::HTTP.new(url.host,url.port )
					http.use_ssl = true
					http.verify_mode = OpenSSL::SSL::VERIFY_NONE

					request = Net::HTTP::Post.new(url.request_uri, header)
					request.body = payload.to_json
					http.request(request)
				end
		end
	end
end