module Hello
  module Authentication
    class SudoModeController < ApplicationController
      kick :guest, :onboarding

      # GET /hello/sudo_mode
      def form
        render_sudo_mode_form
      end

      # PATCH /hello/sudo_mode
      def authenticate
        business = Business::Authentication::SudoModeAuthentication.new(current_access)

        if business.authenticate!(password_param)
          path_to_go = session[:url] || root_path
          flash[:notice] = business.success_message
          redirect_to path_to_go
        else
          flash.now[:alert] = business.alert_message
          render_sudo_mode_form
        end
      end

      # GET /hello/sudo_mode/expire
      def expire
        business = Business::Authentication::SudoModeExpiration.new(current_access)
        business.expire!
        flash[:notice] = business.success_message
        redirect_to '/'
      end

      private

      def password_param
        params.require(:user)[:password]
      end
    end
  end
end
