class Area < ActiveRecord::Base
	belongs_to :city
	has_many :shops

  has_and_belongs_to_many :chains, :uniq => true#, join_table: 'chains' #class_name: 'AreaChain'

  def to_s
    name
  end
  def to_label
    name + ' ' + self.city.name
  end

  #def name
  #  return name # + ' - ' + self.city.name
  #end
end
