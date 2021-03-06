class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_format
  before_action :authenticate_user!
  def set_format
    request.format = :json
  end

  def user_not_authorized
    render json: "Pundit Error: User is not authorized"
  end

  def check_user
    # render 'not_allowed' unless @question.user_id == params[:user_id]
  end

end
