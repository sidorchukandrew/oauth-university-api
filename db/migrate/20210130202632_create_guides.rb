class CreateGuides < ActiveRecord::Migration[6.1]
  def change
    create_table :guides do |t|
      t.timestamp :published_date
      t.string :title
      t.text :short_description
      t.int :read_time

      t.timestamps
    end
  end
end
