require 'spec_helper'

feature 'Manage recipes', %q{
    So that I can store, retrieve and update my Recipes
    As a Guest
    I should be able to
} do

  context 'when creating a recipe' do
    scenario 'creating an invalid recipe' do
      visit new_recipe_path

      click_button 'Create Recipe'

      current_path.should == recipes_path
      page.should have_content("Name can't be blank")
    end

    scenario 'creating a valid model' do
      visit new_recipe_path

      fill_in 'Name', :with => 'Test Recipe'
      click_button 'Create Recipe'

      @recipe = Recipe.find_by_name 'Test Recipe'
      @recipe.should be_present
      current_path.should == recipe_path(@recipe)
    end
  end

  context 'when updating recipes' do

    before(:each) do
      @recipe = Factory.create :recipe
    end

    scenario 'updating the model' do
      visit edit_recipe_path(@recipe)

      fill_in 'Name', :with => 'Apple Pie'
      click_button 'Update Recipe'

      current_path.should == recipe_path(@recipe)
      page.should have_content('Apple Pie')
      @recipe.reload.name.should == 'Apple Pice'
    end

    scenario 'updating a model with invalid attributes' do
      visit edit_recipe_path(@recipe)

      fill_in 'Name', :with => ''
      click_button 'Update Recipe'

      current_path.should == recipe_path(@recipe)
      page.should have_content("Name can't be blank")
    end
  end

  scenario 'when destroying the recipes' do

    before(:each) do
      @recipe = Factory.create :recipe
    end

    scenario 'deleting the recipe' do
      visit recipes_path
      within *row_containing(@recipe) do
        click_link 'Destroy'
      end

      current_path.should == recipes_path
      Recipe.find_by_id(@recipe.id).should_not be_present
    end
  end
end
