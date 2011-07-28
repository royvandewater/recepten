require 'spec_helper'

feature 'Manage ingredients', %q{
  So that I can know what goes into my recipe
  As a guest
  I should be able to
} do

  context 'view a list of ingredients' do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    scenario 'with no existing ingredients' do
      visit recipe_path @recipe

      page.should have_content 'This recipe has no ingredients'
    end

    scenario 'with existing ingredients' do
      Factory.create :ingredient, :name => 'apple', :recipe => @recipe
      Factory.create :ingredient, :name => 'pie',   :recipe => @recipe
      visit recipe_path @recipe

      page.should have_content 'apple'
      page.should have_content 'pie'
    end
  end

  context 'adding a new ingredient' do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    scenario 'with invalid parameters' do
      visit edit_recipe_path @recipe

      fill_in 'Ingredient name', :with => 'Apple'
      fill_in 'Amount', :with => '3 pc'
      click_button 'Add Ingredient'

      Ingredient.find_by_name('Apple').should be_present
      page.should have_content 'Ingredient Created'
      page.should have_content 'Apple'
    end

  end

end
