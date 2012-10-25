class User < ActiveRecord::Base
  rolify
  establish_connection "production"  
  
  rolify :before_add => :before_add_method

  def before_add_method(role)
    # do something before it gets added
  end

  authenticates_with_sorcery!

  has_many :shops, through: :user_shops
  has_many :user_shops
  belongs_to :city
  has_many :promotions
  has_many :discussions
  
  attr_accessible :email, :password, :password_confirmation, :city_id

  validates_confirmation_of :password, :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def to_s
  	self.email	
  end

  def admin?
    self.admin == true
  end

  def seller?
    self.has_role?(:seller, :any) || self.has_role?(:city, :any) || self.has_role?(:area, :any)
  end

  def chain
    Chain.find(roles.find_by_name('seller').resource_id)
  end

  def update_password(current_password, new_password, new_password_confirmation)
    if new_password == new_password_confirmation
      if !User.authenticate(self.email, current_password).nil?
        return self.change_password!(new_password)
      else
        return false
      end
    else
      return false
    end
  end

end
