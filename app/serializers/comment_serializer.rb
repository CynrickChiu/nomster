class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :rating, :user_id, :place_id
  belongs_to :place
end
