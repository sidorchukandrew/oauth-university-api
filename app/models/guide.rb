class Guide < ApplicationRecord
    has_many :sections, :dependent => :destroy, :autosave => true

    accepts_nested_attributes_for :sections

    belongs_to :series, :optional => true
end
