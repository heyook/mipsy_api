module Api
  module V1
    class Users::BaseController < Api::V1::BaseController
      include SimpleTokenAuth::AuthenticateWithToken
      prepend_before_action :authenticate_user_from_token!
    end
  end
end
