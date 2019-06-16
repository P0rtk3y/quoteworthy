#migrations build and structure database (version control)
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      #:password_digest links to bcrypt gem
      t.string :password_digest
    end
  end
end
