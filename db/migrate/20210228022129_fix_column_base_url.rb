class FixColumnBaseUrl < ActiveRecord::Migration[6.1]
  def change
    rename_column :oauth_configs, :baseUrl, :base_url  
  end
end
