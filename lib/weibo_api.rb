class WeiboApi

  attr_reader :client, :access_token

  def initialize(key, secret, token_str, opts={})
    options = {
        :site           => "https://api.weibo.com",
        :authorize_url  => "/oauth2/authorize",
        :token_url      => "/oauth2/access_token"
      }.merge(opts)

    @client       = ::OAuth2::Client.new(key, secret, options)
    @access_token = ::OAuth2::AccessToken.from_hash(
      @client,
      {"access_token" => token_str}
    )
  end

  def get_status(status_id, opts={})
    options = {
      access_token: access_token.token,
      id: status_id
    }.merge(opts)

    pstr = options.map{|k,v| "#{k}=#{v}"}.join('&')
    access_token.get("/2/statuses/show.json?#{pstr}").parsed
  end

  def repost(weibo_id, opts={})
    options = {
      access_token: access_token.token,
      id: weibo_id,
      status: "",
      is_comment: 0
    }.merge(opts)

    pstr = options.map{|k,v| "#{k}=#{v}"}.join('&')
    access_token.post("/2/statuses/repost.json?#{pstr}").parsed
  end
end
