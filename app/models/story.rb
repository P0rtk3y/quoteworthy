class Story < ActiveRecord::Base
  belongs_to :user
  has_many :quotes

  #can add .errors.full_messages to the object to check for errors and call .valid?
  validates_presence_of :name, :author

end
