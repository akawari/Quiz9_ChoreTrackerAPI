module Api::V1
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :points, :active
  has_many :chores
end
end
