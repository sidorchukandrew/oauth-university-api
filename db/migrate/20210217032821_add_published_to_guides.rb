class AddPublishedToGuides < ActiveRecord::Migration[6.1]
  def change
    add_column :guides, :published, :boolean
  end
end
