class StudentSerializer < ActiveModel::Serializer
    attributes :id, :name, :major, :instructor_id

    belongs_to :instructor
end