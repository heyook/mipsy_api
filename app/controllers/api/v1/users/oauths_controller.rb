module Api
  module V1
    class Users::OauthsController < Api::V1::Users::BaseController
      skip_before_action :verify_authenticity_token

      def create
        begin
          info        = find_oauth_info
          user_params = {
            username: info[:info][:nickname],
            provider: info[:provider],
            uid:      info[:uid]
          }

          user     = UserAuthenticator.new.call({ auth: info, user: user_params })
          is_valid = user.valid?
          user.renew_api_key if is_valid

          respond_with user.reload, location: nil, scope: is_valid
        rescue SimpleMobileOauth::Authenticator::BaseError => e
          render json: {errors: e.message}, status: :unprocessable_entity
        end
      end

      private

      def find_oauth_info
        auth_class.new(oauth_params[:code]).oauth_info
      end

      def auth_class
        "#{params[:provider]}_authenticator".camelize.constantize
      end

      def oauth_params
        params.require(:code, :provider)
      end

    end
  end
end
