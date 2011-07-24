require 'spec_helper'

describe RecipesController do

  def valid_attributes
    {:name => 'Apple Pie'}
  end

  describe "GET index" do
    it "assigns all recipes" do
      @recipe = Factory.create :recipe

      get :index
      assigns(:recipes).should eq([@recipe])
    end
  end

  describe "GET show" do
    it "assigns the requested recipe as @recipe" do
      @recipe = Factory.create :recipe
      get :show, :id => @recipe.id
      assigns(:recipe).should eq(@recipe)
    end
  end

  describe "GET new" do
    it "assigns a new recipe as @recipe" do
      get :new
      assigns(:recipe).should be_a_new(Recipe)
    end
  end

  describe "GET edit" do
    it "assigns the requested recipe as @recipe" do
      @recipe = Factory.create :recipe
      get :edit, :id => @recipe.id
      assigns(:recipe).should eq(@recipe)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, :recipe => valid_attributes
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created recipe as @recipe" do
        post :create, :recipe => valid_attributes
        assigns(:recipe).should be_a(Recipe)
        assigns(:recipe).should be_persisted
      end

      it "redirects to the created recipe" do
        post :create, :recipe => valid_attributes
        response.should redirect_to(Recipe.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved recipe as @recipe" do
        Recipe.any_instance.stub(:save).and_return(false)
        post :create, :recipe => {}
        assigns(:recipe).should be_a_new(Recipe)
      end

      it "re-renders the 'new' template" do
        Recipe.any_instance.stub(:save).and_return(false)
        post :create, :recipe => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before :each do
      @recipe = Factory.create :recipe
    end

    describe "with valid params" do
      it "updates the requested recipe" do
        Recipe.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => @recipe.id, :recipe => {'these' => 'params'}
      end

      it "assigns the requested recipe as @recipe" do
        put :update, :id => @recipe.id, :recipe => valid_attributes
        assigns(:recipe).should eq(@recipe)
      end

      it "redirects to the recipe" do
        put :update, :id => @recipe.id, :recipe => valid_attributes
        response.should redirect_to(@recipe)
      end
    end

    describe "with invalid params" do
      it "assigns the recipe as @recipe" do
        Recipe.any_instance.stub(:save).and_return(false)
        put :update, :id => @recipe.id, :recipe => {}
        assigns(:recipe).should eq(@recipe)
      end

      it "re-renders the 'edit' template" do
        Recipe.any_instance.stub(:save).and_return(false)
        put :update, :id => @recipe.id, :recipe => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @recipe = Factory.create :recipe
    end

    it "destroys the requested recipe" do
      expect {
        delete :destroy, :id => @recipe.id
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      delete :destroy, :id => @recipe.id
      response.should redirect_to(recipes_url)
    end
  end

end
