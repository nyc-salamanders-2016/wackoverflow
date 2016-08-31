class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id, null: false
      t.integer :commentable_type, null: false
      t.integer :author_id, null: false
      t.text    :body, null: false

      t.timestamps null: false
    end
  end
end
