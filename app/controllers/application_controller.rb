class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # def index
  #   render html: "Sample app"
  # end
  # allow_browser versions: :modern
  protect_from_forgery with: :exception
  include SessionsHelper
end
