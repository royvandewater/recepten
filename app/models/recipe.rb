class Recipe < ActiveRecord::Base
  has_many :ingredients

  validates_presence_of :name
  validates_uniqueness_of :name

  def has_ingredients?
    ingredients.count > 0
  end

  def to_s
    name
  end
end
