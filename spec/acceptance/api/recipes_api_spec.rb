require 'spec_helper'

feature 'Recipes API', %q{
  So that I can manage the Recipe resources
  As an API User
  I should be able to
} do

  background do
    Capybara.current_driver = :rack_test
  end

  context 'creating recipes' do
    scenario 'create recipe' do
      page.driver.post recipes_path(:format => :json), :recipe => {:name => 'Test Recipe'}

      Recipe.find_by_name('Test Recipe').should be_present
      page.status_code.should == 201
      page.should have_content 'Test Recipe'
    end

    scenario 'attempting to create an invalid recipe' do
      page.driver.post recipes_path(:format => :json), :recipe => {}

      Recipe.find_by_name('Test Recipe').should_not be_present
      page.should have_content '{"name":["can\'t be blank"]}'
    end
  end

  context 'updating recipes' do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    scenario 'updating the Recipe' do
      @recipe.name = "Updated Recipe"
      page.driver.put recipe_path(@recipe, :format => :json), :recipe => @recipe.attributes

      @recipe.reload.name.should == "Updated Recipe"
      page.status_code.should == 200
      page.should have_no_content ''
    end

    scenario 'attempting to update a recipe with invalid attributes' do
      @recipe.name = ''
      page.driver.put recipe_path(@recipe, :format => :json), :recipe => @recipe.attributes

      @recipe.reload.name.should_not == ''
      page.status_code.should == 422
      page.should have_content '{"name":["can\'t be blank"]}'
    end
  end

  describe "destroying the recipe" do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    it 'should destroy the recipe' do
      page.driver.delete recipe_path(@recipe, :format => :json)

      Recipe.find_by_id(@recipe.id).should_not be_present
      page.status_code == 200
      page.should have_no_content ''
    end
  end
end
