class UserSerializer < ActiveModel::Serializer
  attributes :id, :auth_token, :username, :avatar_url

  has_one :api_key

  def filter(keys)
    if scope
      keys
    else
      keys - [:auth_token, :api_key]
    end
  end

end
