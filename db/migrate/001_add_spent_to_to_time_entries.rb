class AddSpentToToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :spent_to, :date, null: true
  end
end
