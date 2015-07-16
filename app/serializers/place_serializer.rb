class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :description, :latitude, :longitude
  has_many :comments
end
