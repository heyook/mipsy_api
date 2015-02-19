class UserAuthenticator
  include SimpleMobileOauth::Authenticator

  find_identity do |params|
    Identity.find_by params.merge(identifiable_type: 'User')
  end

  find_user do |params|
    params.permit!
    identity = Identity.find_by params.slice(:uid, :provider).merge(identifiable_type: 'User')
    identity.try(:identifiable)
  end

  build_user do |params|
    raise ArgumentError, 'missing params' unless params
    attrs = {username: params['username'], password: Devise.friendly_token[0,20]}
    user = User.new(attrs)
    user.skip_confirmation!
    user
  end
end
