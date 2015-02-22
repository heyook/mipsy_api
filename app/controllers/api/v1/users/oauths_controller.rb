module Api
  module V1
    class Users::OauthsController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token

      def create
        user = AuthenticateOauthUser.(oauth_params).user
        respond_with user,
          location: nil,
          scope: true,
          serializer: UserSerializer
      end

      private

      def oauth_params
        params.require(:code)
        params.require(:provider)
        params
      end

    end
  end
end
