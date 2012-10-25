#encoding: utf-8
class Article < ActiveRecord::Base
  #attr_accessible :title, :body

  #before_save :set_permalink
  validates :title, :presence => :true
  #permalink :title, :to_param => %w(id permalink)

  #acts_as_nested_set

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  #def to_label
  #  self.title
  #end

  #private
  #  
  #  def set_permalink
  #    self.permalink = Russian.translit(self.title).mb_chars.downcase.gsub(/[^0-9а-яa-z]+/, ' ').strip.gsub(' ', '-').to_s
  #  end
end
