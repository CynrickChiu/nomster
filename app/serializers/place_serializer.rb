class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :description, :latitude, :longitude
end
