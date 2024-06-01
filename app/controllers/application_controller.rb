class ApplicationController < ActionController::Base
    # before_action :configure_permitted_parameters
    before_action :authenticate_user!

end
