class RenameCanceledOnToSuspendedOnInSubscriptions < ActiveRecord::Migration
  def change
    rename_column :subscriptions, :canceled_on, :suspended_on
  end
end
