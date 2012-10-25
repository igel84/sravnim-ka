class XmlFile < ActiveRecord::Base
  attr_accessor :chain_id

  has_attached_file :attach
  belongs_to :shop
end
