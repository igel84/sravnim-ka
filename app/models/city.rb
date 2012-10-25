class City < ActiveRecord::Base
  establish_connection "production"
  resourcify

  default_scope order('alias')

  has_many :areas
	has_many :users

  has_and_belongs_to_many :chains, :uniq => true

  def to_s
    name
  end

  #def areas
  #  ActiveRecord::Base.clear_cache!
  #  ActiveRecord::Base.establish_connection(
  #    adapter: 'sqlite3',
  #    database: "db/#{self.name}.sqlite3",
  #    pool: 5,
  #    timeout: 5000
  #  )
  #  return Areas.where(city_id: self.id) 
  #end
end
