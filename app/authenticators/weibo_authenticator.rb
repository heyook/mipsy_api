class WeiboAuthenticator

  attr_reader :options

  def initialize(auth_code, opts={})
    @auth_code = auth_code
    @options   = {
        :site           => "https://api.weibo.com",
        :authorize_url  => "/oauth2/authorize",
        :token_url      => "/oauth2/access_token"
      }.merge(opts)
  end

  def oauth_info
    {
      provider: "weibo",
      uid: uid,
      info: user_info,
      access_token: access_token.token,
      extra: { raw_info: raw_info }
    }
  end

  private

  def client
    @client ||= \
      OAuth2::Client.new(ENV['WEIBO_KEY'], ENV['WEIBO_SECRET'], options.clone)
  end

  def user_info
    {
      :nickname     => raw_info['screen_name'],
      :name         => raw_info['name'],
      :location     => raw_info['location'],
      :image        => find_image,
      :description  => raw_info['description'],
      :urls => {
        'Blog'      => raw_info['url'],
        'Weibo'     => raw_info['domain'].present? ? "http://weibo.com/#{raw_info['domain']}" : "http://weibo.com/u/#{raw_info['id']}",
      }
    }
  end

  def uid
    access_token.params["uid"]
  end

  def raw_info
    @raw_info ||= \
      access_token.get("/2/users/show.json?", :params => {uid: uid, access_token: access_token.token}).parsed
  end

  def find_image
    raw_info[%w(avatar_hd avatar_large profile_image_url).find { |e| raw_info[e].present? }]
  end

  def access_token
    @access_token ||= \
      client.auth_code.get_token(@auth_code, :redirect_uri => ENV['WEIBO_REDIRECT_URI'], parse: :json)
  end

end
