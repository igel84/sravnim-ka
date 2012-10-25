class Chain < ActiveRecord::Base
  establish_connection "production"
  resourcify
  
	has_many :shops

  has_and_belongs_to_many :cities, :uniq => true
  has_and_belongs_to_many :areas, :uniq => true

	has_attached_file :logo, :styles => { :thumb=> ["140x140", :png] }, :whiny => false

   def to_s
    name
  end
end
