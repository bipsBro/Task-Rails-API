
module Api
	module V1
		class SessionController < ApplicationController
			skip_before_action :require_lofin!, only: [:create]
			# acts_as_token_authentication_handler_for User
			def create
				user = User.where(email: params[:email]).first
				if user && user.valid_password?(params[:password])
					# render json: user.as_json(only: [:email, :authentication_token]), status: :created
					render json: {status: 'SUCCESS', errors:[], data: user.as_json(only: [:name, :email, :authentication_token]) }, status: :ok
				else
					invalide_login
				end
			end
			def destroy
				
			end

			private
				def invalide_login
					render json: {status: 'ERROR', errors:{message: 'Invalid email or password'} }, status: 401			
				end
		end
	end
end