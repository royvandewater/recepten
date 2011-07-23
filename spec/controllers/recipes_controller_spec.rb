require 'spec_helper'

describe RecipesController do
  describe 'creating recipes' do
    it 'should create an instance' do
      post :create, :format => :json, :recipe => {:name => 'Test Recipe'}

      Recipe.find_by_name('Test Recipe').should be_present
      response.status.should == 201
      response.body.should include 'Test Recipe'
    end

    it 'should fail to save and return errors' do
      post :create, :format => :json, :recipe => {}

      Recipe.find_by_name('Test Recipe').should_not be_present
      response.body.should include '{"name":["can\'t be blank"]}'
    end
  end

  describe 'updating recipes' do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    it 'should update the Recipe' do
      @recipe.name = "Updated Recipe"
      put :update, :format => :json, :id => @recipe.id, :recipe => @recipe.attributes

      Recipe.find(@recipe.id).name.should == "Updated Recipe"
      response.status.should == 200
      response.body.should be_blank
    end

    it 'should fail to save and return errors' do
      @recipe.name = ''
      put :update, :format => :json, :id => @recipe.id, :recipe => @recipe.attributes

      Recipe.find(@recipe.id).name.should_not == ''
      response.body.should include '{"name":["can\'t be blank"]}'
    end
  end

  describe "destroying the recipe" do
    before(:each) do
      @recipe = Factory.create :recipe
    end

    it 'should destroy the recipe' do
      delete :destroy, :format => :json, :id => @recipe.id

      Recipe.find_by_id(@recipe.id).should_not be_present
      response.status == 200
      response.body.should be_blank
    end
  end
end
