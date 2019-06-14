class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :content
      t.integer :story_id
      t.integer :user_id
    end
  end
end
