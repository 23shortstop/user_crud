class RenameTokensToAuthentications < ActiveRecord::Migration
  def change
    rename_table :tokens, :authentications
  end
end
