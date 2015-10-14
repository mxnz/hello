require "application_responder"
require 'trailblazer/operation/controller/active_record'

class ApplicationController < ActionController::Base
  include Pundit
  include Trailblazer::Operation::Controller
  include Trailblazer::Operation::Controller::ActiveRecord # named instance variables.

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action ->() { params.merge!(current_user: current_user) }, if: :user_signed_in?

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def configure_permitted_parameters
      (devise_parameter_sanitizer.for(:sign_up) <<
        [:name, :last_name, :avatar, :passport_photo, :birthdate, :store]).flatten
    end
end
