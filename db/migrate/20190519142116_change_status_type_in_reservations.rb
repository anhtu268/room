class ChangeStatusTypeInReservations < ActiveRecord::Migration[5.2]
  def change
    change_column :reservations, :status, :integer, limit: 1, default: 0
  end
end
