module WeiboRefresh
  extend self

  InvalidAccessToken = Class.new ArgumentError

  def call(user, opts={})
    access_token = user.weibo_identity.try(:access_token)
    raise InvalidAccessToken if access_token.blank?

    #TODO: only load weibo reposts
    api = WeiboApi.new(key, secret, access_token)

    user.reposts.each do |repost|
      begin
        res = api.get_status repost.ref_id
      rescue OAuth2::Error => e
        Rails.logger.info e
      end
      repost.info = build_info res
      repost.save
      sleep(1)
    end

  end

  private

  def key
    ENV['WEIBO_KEY']
  end

  def secret
    ENV["WEIBO_SECRET"]
  end

  def build_info(res)
    res.slice(
      "reposts_count",
      "comments_count",
      "attitudes_count"
    )
  end

end
