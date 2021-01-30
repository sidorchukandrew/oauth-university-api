class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.text :content
      t.int :ordinal

      t.timestamps
    end
  end
end
