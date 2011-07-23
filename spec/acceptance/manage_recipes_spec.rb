require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Managing recipes', :type => :request do

  context 'When creating a recipe' do
    it 'should display errors on invalid model' do
      visit new_recipe_path

      click_button 'Create Recipe'
    end

    it 'should save an instance and redirect to show' do
      visit new_recipe_path

      fill_in 'Name', :with => 'Test Recipe'
      click_button 'Create Recipe'

      @recipe = Recipe.find_by_name 'Test Recipe'
      @recipe.should be_present
      current_path.should == recipe_path(@recipe)
    end
  end
end
