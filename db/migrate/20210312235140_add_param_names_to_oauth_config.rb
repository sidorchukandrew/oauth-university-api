class AddParamNamesToOauthConfig < ActiveRecord::Migration[6.1]
  def change
    add_column :oauth_configs, :redirect_uri_param_name, :string
    add_column :oauth_configs, :client_id_param_name, :string
    add_column :oauth_configs, :scope_param_name, :string
  end
end
