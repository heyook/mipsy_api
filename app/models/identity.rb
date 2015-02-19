class Identity < ActiveRecord::Base
  validates :uid, :provider, presence: true
  validates_uniqueness_of :uid, scope: [:provider, :identifiable_type]

  belongs_to :identifiable, polymorphic: true

  serialize :info, JSON

  def username
    info["nickname"]
  end

  def avatar_url
    info["image"]
  end

  before_save :update_identifiable, if: -> { info.present? }

  private

  def update_identifiable
    info_sym = info.stringify_keys
    identifiable.username   = info_sym["nickname"]
    identifiable.avatar_url = info_sym["image"]
    identifiable.save
  end

end
