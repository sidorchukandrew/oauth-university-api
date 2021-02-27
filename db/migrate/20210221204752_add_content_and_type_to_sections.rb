class AddContentAndTypeToSections < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :type, :string
  end
end
