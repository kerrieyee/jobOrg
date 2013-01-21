class ApplicationController < ActionController::Base
	before_filter :authenticate_user!
	protect_from_forgery

	def correct_user?(expected_user, actual_user)
		expected_user == actual_user
	end

	def redirect_unauthorized_user
		redirect_to root_path	
		flash[:error] = "You are not allowed to access this page"
	end

end
