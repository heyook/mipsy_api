class UserSerializer < ActiveModel::Serializer
  attributes :id, :auth_token, :username, :avatar_url, :weibo_identity

  has_one :api_key, serializer: ApiKeySerializer
  has_one :weibo_identity, serializer: IdentitySerializer

  def filter(keys)
    if scope
      keys
    else
      keys - [:auth_token, :api_key, :weibo_identity]
    end
  end

end
