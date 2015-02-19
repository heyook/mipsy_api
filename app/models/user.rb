class User < ActiveRecord::Base
  include SimpleMobileOauth::Identifiable
  include SimpleTokenAuth::TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
