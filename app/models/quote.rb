class Quote < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :content, presence: {message: "is empty and unquotable!"}
  validates :content, uniqueness: {case_sensitive: false, message: "has been quoted before!"}

end
