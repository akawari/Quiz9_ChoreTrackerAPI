module Api::V1
class UserSerializer < ActiveModel::Serializer
  attributes :email, :api_key, :active
end
end