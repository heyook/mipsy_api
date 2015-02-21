module Api
  module V1
    class Users::AccountsController < Users::BaseController
      def show
        respond_with current_user, scope: current_user
      end
    end
  end
end
