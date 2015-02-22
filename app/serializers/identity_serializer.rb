class IdentitySerializer < ActiveModel::Serializer
  attributes :id, :uid, :provider, :access_token
end
