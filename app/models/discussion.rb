class Discussion < ActiveRecord::Base
  establish_connection "production"
  acts_as_tree
  
  belongs_to :user  
end
