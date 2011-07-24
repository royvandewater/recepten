require 'spec_helper'

describe Ingredient do
  before(:each) do
    @recipe = Factory.create :recipe
  end

  describe 'validations' do
    it 'should require a name' do
      @ingredient = Ingredient.new

      @ingredient.save.should be_false
      @ingredient.errors[:name].should include "can't be blank"
    end

    it 'should require an amount' do
      @ingredient = Ingredient.new :name => 'apple'

      @ingredient.save.should be_false
      @ingredient.errors[:amount].should include "can't be blank"
    end

    it 'should require a recipe' do
      @ingredient = Ingredient.new :name => 'apple', :amount => 'a bit'

      @ingredient.save.should be_false
      @ingredient.errors[:recipe].should include "can't be blank"
    end
  end

  describe 'relationships' do
    it 'should belong to a recipe' do
      @ingredient = Ingredient.new :name => 'apple', :amount => 'a bit', :recipe => @recipe
      @ingredient.save
      Ingredient.last.recipe.should == @recipe
    end
  end
end
