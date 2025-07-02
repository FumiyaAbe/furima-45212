class ApplicationController < ActionController::Base
  # 全ページでBasic認証を有効にする
  before_action :basic_auth

  # ルートパス用のindexアクション
  def index
    render template: 'items/index'
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
