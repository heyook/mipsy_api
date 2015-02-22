class AuthenticateOauthUser
  include ResourceModel::Model
  alias_resource :user

  attr_reader :code, :provider

  def initialize(params)
    @code     = params[:code]
    @provider = params[:provider]
  end

  def info
    @info ||= auth_class.new(code).oauth_info
  end

  def oauth_info
    {
      auth: info,
      user: {
        username: info[:info][:nickname],
        provider: info[:provider],
        uid:      info[:uid]
      }
    }
  end

  def access_token
    info[:access_token]
  end

  def call
    @resource = UserAuthenticator.new.call \
      ActiveSupport::HashWithIndifferentAccess.new(oauth_info)
    if user.valid?
      user.renew_api_key
      update_access_token user
      user.reload # to make user resource is the latest
    end
  rescue SimpleMobileOauth::Authenticator::BaseError => e
    user.errors.add(:base, e.message)
  end

  private

  def update_access_token(user)
    identity = user.identities.find_by provider: provider
    identity.update_attribute :access_token, access_token
  end

  def auth_class
    "#{provider}_authenticator".camelize.constantize
  end

end
