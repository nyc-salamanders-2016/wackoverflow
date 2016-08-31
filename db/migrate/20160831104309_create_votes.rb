class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer   :user_id, null: false
      t.integer   :votable_id, null: false
      t.string    :votable_type, null: false
      t.integer   :value

      t.timestamps null: false 
    end
    add_index :votes, [:user_id, :votable_type, :votable_id], unique: true
  end
end
