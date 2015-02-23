module Api
  module V1
    class Users::RepostsController < Users::BaseController

      def create
        repost = WeiboRepost.(current_user, repost_params).resource
        respond_with repost, location: nil, serializer: RepostSerializer
      end

      private

      def repost_params
        params.require(:repost).permit(:title, :article_id, :ref_id, :ref_type)
      end

    end
  end
end
