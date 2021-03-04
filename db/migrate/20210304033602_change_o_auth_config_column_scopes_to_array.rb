class ChangeOAuthConfigColumnScopesToArray < ActiveRecord::Migration[6.1]
  def change
    change_column :oauth_configs, :scopes, :text, array: true, default: [], using: "(string_to_array(scopes, ','))"
  end
end
