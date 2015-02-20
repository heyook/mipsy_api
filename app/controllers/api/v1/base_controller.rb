module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      
      protected

      def record_not_found
        render json: ServiceResult::Error.new('record not found'), \
          status: :unprocessable_entity
      end
    end
  end
end
