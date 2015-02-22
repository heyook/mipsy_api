class UserSerializer < ActiveModel::Serializer
  attributes :id, :auth_token, :username, :avatar_url, :weibo_info

  has_one :api_key, serializer: ApiKeySerializer

  def filter(keys)
    if scope
      keys
    else
      keys - [:auth_token, :api_key, :weibo_info]
    end
  end

  def weibo_info
    @weibo ||= begin
      identity = object.identities.find_by provider: "weibo"
      if identity.present?
        IdentitySerializer.new(identity).as_json(root: false)
      else
        nil
      end
    end
  end

end
