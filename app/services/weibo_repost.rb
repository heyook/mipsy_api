class WeiboRepost
  include ResourceModel::Model
  alias_resource :repost

  attr_reader :user

  InvalidAccessToken = Class.new ArgumentError

  def initialize(user, opts={})
    params = {
      ref_type: "weibo"
    }.merge(opts)

    @user     = user
    @resource = user.reposts.build params
  end

  def call
    article      = Article.find repost.article_id
    access_token = user.weibo_identity.try(:access_token)
    raise InvalidAccessToken if access_token.blank?

    api = WeiboApi.new(ENV['WEIBO_KEY'], ENV["WEIBO_SECRET"], access_token)
    res = api.repost(article.ref_id)
    repost.ref_id = res["idstr"]
    repost.info   = build_info res
    repost.save
  rescue OAuth2::Error => e
    repost.errors.add(:base, e.message)
    return
  rescue InvalidAccessToken
    repost.errors.add(:base, I18n.t("weibo.invalid_access_token"))
    return
  end

  private

  def build_info(res)
    res.slice(
      "reposts_count",
      "comments_count",
      "attitudes_count"
    )
  end

end
