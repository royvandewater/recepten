require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Managing recipes', :type => :request do

  context 'When creating a recipe' do
    it 'should display errors on invalid model' do
      visit new_recipe_path

      click_button 'Create Recipe'

      current_path.should == recipes_path
      page.should have_content("Name can't be blank")
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

  context 'when updating recipes' do

    before(:each) do
      @recipe = Factory.create :recipe
    end

    it 'should display errors on an invalid model' do
      visit edit_recipe_path(@recipe)

      fill_in 'Name', :with => ''
      click_button 'Update Recipe'

      current_path.should == recipe_path(@recipe)
      page.should have_content("Name can't be blank")
    end
  end

  context 'when destroying the recipes' do

    before(:each) do
      @recipe = Factory.create :recipe
    end

    it 'should delete the recipe' do
      visit recipes_path
      within *row_containing(@recipe) do
        click_link 'Destroy'
      end

      current_path.should == recipes_path
      Recipe.find_by_id(@recipe.id).should_not be_present
    end
  end
end
