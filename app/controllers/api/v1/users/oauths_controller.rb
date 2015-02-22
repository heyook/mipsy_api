module Api
  module V1
    class Users::OauthsController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token
      before_action :find_oauth_info, only: [:create]

      def create
        begin
          oauth_hash = ActiveSupport::HashWithIndifferentAccess.new(@oauth_info)
          user       = UserAuthenticator.new.(oauth_hash)
          if user.valid?
            user.renew_api_key
            # user.update_access_token
          end 

          respond_with user.reload,
            location: nil,
            scope: true,
            serializer: UserSerializer

        rescue SimpleMobileOauth::Authenticator::BaseError => e
          render json: {errors: e.message}, status: :unprocessable_entity
        end
      end

      private

      def find_oauth_info
        info = auth_class.new(oauth_params[:code]).oauth_info
        @access_token = info[:access_token]
        @oauth_info   = {
          auth: info,
          user: {
            username: info[:info][:nickname],
            provider: info[:provider],
            uid:      info[:uid]
          }
        }
      end

      def auth_class
        "#{oauth_params[:provider]}_authenticator".camelize.constantize
      end

      def oauth_params
        params.require(:code)
        params.require(:provider)
        params
      end

    end
  end
end
