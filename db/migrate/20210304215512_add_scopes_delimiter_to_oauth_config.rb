class AddScopesDelimiterToOauthConfig < ActiveRecord::Migration[6.1]
  def change
      add_column :oauth_configs, :scope_delimiter, :string
  end
end
