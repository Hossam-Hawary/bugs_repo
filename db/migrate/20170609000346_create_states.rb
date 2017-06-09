class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :devise
      t.string :os
      t.integer :memory
      t.integer :storage

      t.timestamps
    end
  end
end
