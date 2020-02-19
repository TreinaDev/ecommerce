class AddNeighborhoodToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :neighborhood, :string
  end
end
