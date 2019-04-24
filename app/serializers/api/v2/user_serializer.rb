module Api::V2
class UserSerializer < ActiveModel::Serializer
  attributes :email, :api_key, :active
end
end