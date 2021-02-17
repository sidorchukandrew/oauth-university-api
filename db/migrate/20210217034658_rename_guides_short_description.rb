class RenameGuidesShortDescription < ActiveRecord::Migration[6.1]
  def change
     change_table :guides do |t|
      t.rename :short_description, :description
    end
  end
end
