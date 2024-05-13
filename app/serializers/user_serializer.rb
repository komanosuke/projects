class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :zip, :prefecture, :city, :street, :address, :tel, :image, :photo, :audio, :video, :profile, :introduction, :created_at, :updated_at
end
