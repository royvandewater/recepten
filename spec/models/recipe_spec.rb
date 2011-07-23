require 'spec_helper'

describe Recipe do
  it 'should require a name' do
    @recipe = Recipe.new

    @recipe.save.should be_false
    @recipe.errors[:name].should include "can't be blank"
  end
end
