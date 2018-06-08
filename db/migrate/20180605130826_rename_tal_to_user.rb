class RenameTalToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :tal, :tel
  end
end
