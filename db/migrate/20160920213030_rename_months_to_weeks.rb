class RenameMonthsToWeeks < ActiveRecord::Migration
  def change
    rename_column :babies, :months, :weeks
  end
end
