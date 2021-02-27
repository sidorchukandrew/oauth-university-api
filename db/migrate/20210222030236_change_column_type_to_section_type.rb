class ChangeColumnTypeToSectionType < ActiveRecord::Migration[6.1]
  def change
    change_table :sections do |t|
      t.rename :type, :section_type
    end
  end
end
