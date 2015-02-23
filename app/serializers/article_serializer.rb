class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :link, :image_url, :ref_id, :ref_type
  has_many :reposts, each_serializer: RepostSerializer

end
