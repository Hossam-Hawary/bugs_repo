class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.string :token
      t.integer :number
      t.string :status, default: :new_bug
      t.string :priority, default: :major
      t.text :comment
      t.references :state, foreign_key: true

      t.timestamps
    end
    add_index :bugs, [:token, :number]
  end
end
