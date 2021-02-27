class RemoveColumnTitleFromSections < ActiveRecord::Migration[6.1]
  def change
    remove_column :sections, :title
  end
end
