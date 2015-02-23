class RepostSerializer < ActiveModel::Serializer
  attributes :id, :title, :ref_id, :ref_type,
    :reposts_count, :comments_count, :attitudes_count

  has_one :article, embed: :id
  has_one :user, embed: :id

  def attitudes_count
    object_info['attitudes_count']
  end

  def comments_count
    object_info['comments_count']
  end

  def reposts_count
    object_info['reposts_count']
  end

  def object_info
    object.info.nil? ? {} : object.info
  end

end
