class ApplicationController < ActionController::Base
  def index
    render template: 'items/index'
  end
end
