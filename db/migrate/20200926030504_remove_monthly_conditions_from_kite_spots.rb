class RemoveMonthlyConditionsFromKiteSpots < ActiveRecord::Migration[6.0]
  def change
    remove_column :kite_spots, :monthly_conditions
  end
end
