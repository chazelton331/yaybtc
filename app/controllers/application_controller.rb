class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV['BASIC_NAME'], password: ENV['BASIC_PASSWORD']

  before_action :find_or_create_current_user

  def find_or_create_current_user
    if ENV['BASIC_NAME']
      @current_user = User.find_or_create_by(name: ENV['BASIC_NAME'])
    end
  end

end
