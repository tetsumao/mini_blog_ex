class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production? 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :email, :profile, :blog_url])
    end

    # 遷移元パスとコントローラ・アクションが一致するならそのパスを返す
    def referer_path_match_controller_action(controller, action)
      path = URI.parse(request.referer).path
      recognized_path = Rails.application.routes.recognize_path(path)
      if recognized_path[:controller] == controller && recognized_path[:action] == action
        path
      else
        nil
      end
    end

  private
    def production?
      Rails.env.production?
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      end
    end
end
