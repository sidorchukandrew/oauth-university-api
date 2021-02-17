class JoinGuideAndSeries < ActiveRecord::Migration[6.1]
  def change
    add_reference(:guides, :series)
  end
end
