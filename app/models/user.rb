#ActiveRecord::Base gives you methods like initialize, new, etc. 
class User < ActiveRecord::Base
  has_secure_password
  has_many :stories
  has_many :quotes
end
