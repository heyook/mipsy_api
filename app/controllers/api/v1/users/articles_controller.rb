module Api
  module V1
    class Users::ArticlesController < Users::BaseController

      def index
        render json: {
          articles: [
            {
              id: 1,
              title: "LA翻译为您免费翻译日常信件, 不用求人啦!",
              link: "http://weibo.com/5273189163/C4NyBlHuD",
              image_url: "http://ww1.sinaimg.cn/bmiddle/005KRLo7jw1epcyqam65yj30p20zsgr0.jpg"
            }
          ]
        }
      end

    end
  end
end
