require 'spec_helper'

feature 'Ingredients API', %q{
  So that I can manage the Ingredients resources
  As an API User
  I should be able to
} do

  background do
    Capybara.current_driver = :rack_test
  end

  context 'creating ingredients' do
    background do
      @recipe = Factory.create :recipe
    end

    scenario 'create recipe' do
      page.driver.post recipe_ingredients_path(@recipe, :format => :json), :ingredient => {:name => 'Test Ingredient', :amount => '2 cup'}

      Ingredient.find_by_name('Test Ingredient').should be_present
      page.status_code.should == 201
      page.should have_content 'Test Ingredient'
    end

  end
end
