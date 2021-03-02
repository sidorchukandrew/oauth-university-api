class Section < ApplicationRecord   
    belongs_to :guide
    has_one :oauth_config, :dependent => :destroy, :autosave => true
    accepts_nested_attributes_for :oauth_config
end
