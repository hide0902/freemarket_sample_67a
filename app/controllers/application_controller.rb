class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # deviseでは初期状態でサインアップ時にメールアドレスとパスワードのみを受け取るようにストロングパラメーターが設定してあるので、追加したキー（name）などのパラメーターは許可されていない。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:birthday,:last_name,:first_name,:ruby_first,:ruby_last])
  end
  def index
    
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
