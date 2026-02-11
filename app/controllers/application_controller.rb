class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :set_locale

  before_action :authenticate_user!

rescue_from CanCan::AccessDenied do |exception|
  redirect_to root_path, alert: "No tienes permiso para realizar esta acción."
end

  def set_locale
    I18n.locale = 'es'
  end
end
