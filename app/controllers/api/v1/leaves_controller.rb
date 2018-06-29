require 'uri'
require 'net/http'
require 'net/https'
require 'json'
module Api
	module V1
		class LeavesController < ApplicationController
			before_action :authenticate
			def index
				# response = notify_slack("#test", "bipin", "hello bro", "image")
				# body = response.body
				articles = Leave.order('created_at DESC').limit(10);
				render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status: :ok
			end
			def show
				articles = Leave.order('created_at DESC');
				render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles}, status: :ok
			end
			def create
				leave = Leave.new(leave_params)
				# print(request.headers)
				user = User.where(authentication_token: request.headers['authentication-token']).first
				# render json: {s: user.id}
				leave.user_id = user.id
				if leave.save
					print(leave)
					userName = leave.user.name
					reason = leave.reason
					leaveType = leave.leavetype
					date = leave.date
					message = "#{userName} Hello, I want to take #{leaveType} leave  on  #{date} leave due to #{reason} reason"
					notify_slack("#test", userName, message, "image")
					render json: {status: 'SUCCESS', message: "succesfully created", data:leave}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Not saved', data:leave.errors}, status: :unprocessable_entry
				end
			end

			private
			def authenticate
				user = User.where(authentication_token: request.headers['authentication-token'])
				return true if user.exists?
				return false
			end
		    def leave_params
		      	params.permit(:date, :leavetype, :reason)
		    end
			def notify_slack(channel, username, text, image)
			  	url = URI.parse('https://slack.com/api/chat.postMessage')
				header = {
					'Content-Type' => 'application/json',
					'Authorization' => '' # Bearer xoxp-XXXXXX......XXXXX
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