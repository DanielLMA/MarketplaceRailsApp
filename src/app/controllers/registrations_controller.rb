class RegistrationsController < Devise::RegistrationsController
	protected
	def after_sign_up_path_for(resource)
    edit_runner_path(resource)
	end
end