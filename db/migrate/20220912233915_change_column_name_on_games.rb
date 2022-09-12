class ChangeColumnNameOnGames < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :resease_date, :release_date
  end
end
