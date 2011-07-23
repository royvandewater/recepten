require 'spec_helper'

describe RecipesController do
  describe 'creating recipes' do
    it 'should create an instance' do
      post :create, :format => :json, :recipe => {:name => 'Test Recipe'}

      Recipe.find_by_name('Test Recipe').should be_present
    end

    it 'should fail to save and return errors' do
      post :create, :format => :json, :recipe => {}

      Recipe.find_by_name('Test Recipe').should_not be_present
      response.body.should include('{"name":["can\'t be blank"]}')
    end
  end
end
