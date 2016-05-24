class RenameAuthenticationsToSessions < ActiveRecord::Migration
  def change
    rename_table :authentications, :sessions
  end
end
