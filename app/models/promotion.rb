class Promotion < ActiveRecord::Base
  establish_connection "production"

  before_create :init_key
  #after_create :destroy_original

  validates_attachment_presence :banner  
  validates_attachment_size :banner, :less_than => 1.megabytes  
  validates_attachment_content_type :banner, :content_type => ['image/jpeg', 'image/png']  

  has_attached_file :banner, :styles => { :original => '130x130#', :thumb => {:geometry => "80x80", :jcrop => true} }, :whiny => false
  belongs_to :user

  def init_key
    #temp_key = "#{(0...5).map{ ('0'..'1000').to_a[rand(26)] }.join}" until Promotion.find_by_key(temp_key).nil?
    #if promotion = Promotion.last
    #  self.key = promotion.try(:key).to_i + 1
    #else
    #  self.key = 17038
    #end
    self.key = "#{(0...4).map{ ('0'...'100').to_a[rand(99)] }.join}"
  end

  def destroy_original
    File.unlink(self.banner.path)
  end

end
