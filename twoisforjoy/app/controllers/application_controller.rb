class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_request
  attr_reader :current_user

  private

    def authenticate_request
      authenticate_token || render_unauthorized("Access denied")
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by(token: token)
      end
    end

    def render_unauthorized(realm = "Application")
      self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Bad credentials', status: :unauthorized
    end
end
