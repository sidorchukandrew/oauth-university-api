class Guide < ApplicationRecord
    has_many :sections, :dependent => :destroy, :autosave => true

    accepts_nested_attributes_for :sections, allow_destroy: true

    belongs_to :series, :optional => true
end
