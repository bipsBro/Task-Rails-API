class LeaveController < ApplicationController
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
	
	def index
		
	end
end
