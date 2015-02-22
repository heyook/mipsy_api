class ApiKeySerializer < ActiveModel::Serializer
  attributes :id, :access_token, :expired_at
end
