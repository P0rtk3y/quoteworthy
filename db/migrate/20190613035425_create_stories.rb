class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.string :author
      t.integer :user_id 
    end
  end
end
