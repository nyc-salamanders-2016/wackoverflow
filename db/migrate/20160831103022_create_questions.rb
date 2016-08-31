class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string    :title, null: false
      t.integer   :author_id, null: false
      t.integer   :chosen_answer_id
      t.text      :body, null: false

      t.timestamps null: false
    end
  end
end
