class Role < ApplicationRecord
    has_and_belongs_to_many :permissions
    has_many :users

    accepts_nested_attributes_for :permissions, allow_destroy: true

end