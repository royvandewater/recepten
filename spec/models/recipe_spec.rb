require 'spec_helper'

describe Recipe do
  describe 'validations' do
    it 'should require a name' do
      @recipe = Recipe.new

      @recipe.save.should be_false
      @recipe.errors[:name].should include "can't be blank"
    end

    it 'should enforce a unique name' do
      Factory.create :recipe, :name => 'Test Recipe'
      @recipe = Recipe.new :name => 'Test Recipe'

      @recipe.save.should be_false
      @recipe.errors[:name].should include 'has already been taken'
    end
  end

  describe 'associations' do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    it 'should have many ingredients' do
      @ingredient = Factory.build :ingredient, :recipe => nil
      @recipe.ingredients << @ingredient

      @recipe.reload
      @recipe.ingredients.should include @ingredient
    end
  end
end
