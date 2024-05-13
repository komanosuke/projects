class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :image, :created_at, :updated_at
  belongs_to :user
end
