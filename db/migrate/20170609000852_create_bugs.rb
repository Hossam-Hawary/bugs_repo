class CreateBugs < ActiveRecord::Migration[5.0]
  def change
    create_table :bugs do |t|
      t.string :token
      t.integer :number
      t.integer :status, default:1
      t.integer :priority, default:1
      t.text :comment
      t.references :state, foreign_key: true

      t.timestamps
    end
    add_index :bugs, :number
  end
end
