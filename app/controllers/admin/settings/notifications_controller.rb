module Admin
  module Settings
    class NotificationsController < BaseController
      def index
        @notifications = Notification.all
      end

      def show

      end

      def edit
        @notification = Notification.find(params[:id])
      end

      def new
        @notification = Notification.new
      end

      def create
        @notification = Notification.create(notification_params)
        if @notification.save
          flash[:notice] = 'New notification created successfully'
          redirect_to admin_settings_notifications_path
        else
          flash[:alert] = 'Creating new notification fails!'
          render :new
        end

      end

      def update

        @notification = Notification.find(params[:id])
        if @notification.update_attributes(notification_params)
          flash[:notice] = 'Notification updated successfully'
          redirect_to admin_settings_notifications_path
        else
          flash[:alert] = 'Updating notification fails!'
          render :edit
        end

      end

      def delete
        Notification.destroy(params[:id])
        flash[:notice] = 'Notification deleted successfully'
        redirect_to admin_settings_notifications_path
      end

      def active
        @notification = Notification.find(params[:id])
        @notification.active = (not @notification.active)
        if @notification.save
          if @notification.active?
            flash[:notice] = 'Notification activated successfully'
          else
            flash[:notice] = 'Notification deactivated successfully'
          end

        else
          flash[:alert] = 'Activating notification fails!'
        end

        redirect_to admin_settings_notifications_path
      end

      private

      def notification_params
        params.required(:notification).permit(:notification_text, :notification_color, :active, :link, :link_text)
      end

    end
  end
end
