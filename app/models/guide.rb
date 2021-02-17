class Guide < ApplicationRecord
    has_many :sections, :dependent => :destroy

    belongs_to :series, :optional => true
end
