class Repost < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  serialize :info, JSON
  validates :article, :ref_id, :ref_type, :user, presence: true

end
