class AddIndexOnTokenToBug < ActiveRecord::Migration[5.0]
  def change
    add_index :bugs, :token
  end
end
