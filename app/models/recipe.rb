class Recipe < ActiveRecord::Base
  has_many :ingredients

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end
end
