class CreateOauthConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :oauth_configs do |t|
      t.string :scopes
      t.string :baseUrl
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
