class AddPublishedToSeries < ActiveRecord::Migration[6.1]
  def change
    add_column :series, :published, :boolean
    add_column :series, :published_date, :datetime
  end
end
