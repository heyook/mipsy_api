module Api
  module V1
    class Users::ArticlesController < Users::BaseController

      def index
        render json: Article.all, each_serializer: ArticleSerializer
      end

    end
  end
end
