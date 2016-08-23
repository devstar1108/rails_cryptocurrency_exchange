module Private
  class SettingsController < BaseController
    def index
      unless current_user.activated?
        flash.now[:info] = t('.activated')
      end
      @notification = Notification.where(active: true).first
    end
  end
end

