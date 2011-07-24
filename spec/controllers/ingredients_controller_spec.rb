require 'spec_helper'

describe IngredientsController do

  def valid_attributes
    {:name => 'apple', :amount => 'a bit'}
  end

  describe "GET index" do
    it "assigns all of a recipe's ingredients as @ingredients" do
      Factory.create :ingredient
      @ingredient = Factory.create :ingredient

      get :index, :recipe_id => @ingredient.recipe.id
      assigns(:ingredients).should eq([@ingredient])
    end
  end

  describe "GET show" do
    it "assigns the requested ingredient as @ingredient" do
      @ingredient = Factory.create :ingredient
      get :show, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id
      assigns(:ingredient).should eq(@ingredient)
    end
  end

  describe "GET new" do
    it "assigns a new ingredient as @ingredient" do
      @recipe = Factory.create :recipe
      get :new, :recipe_id => @recipe.id
      assigns(:ingredient).should be_a_new(Ingredient)
    end
  end

  describe "GET edit" do
    it "assigns the requested ingredient as @ingredient" do
      @ingredient = Factory.create :ingredient
      get :edit, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id
      assigns(:ingredient).should eq(@ingredient)
    end
  end

  describe "POST create" do
    before :each  do
      @recipe = Factory.create :recipe
    end

    describe "with valid params" do
      it "creates a new Ingredient" do
        expect {
          post :create, :recipe_id => @recipe.id, :ingredient => valid_attributes
        }.to change(Ingredient, :count).by(1)
      end

      it "assigns a newly created ingredient as @ingredient" do
        post :create, :recipe_id => @recipe.id, :ingredient => valid_attributes
        assigns(:ingredient).should be_a(Ingredient)
        assigns(:ingredient).should be_persisted
      end

      it "redirects to the created ingredient" do
        post :create, :recipe_id => @recipe.id, :ingredient => valid_attributes
        @ingredient = Ingredient.last
        response.should redirect_to(recipe_ingredient_path @recipe, @ingredient)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ingredient as @ingredient" do
        Ingredient.any_instance.stub(:save).and_return(false)
        post :create, :recipe_id => @recipe.id, :ingredient => {}
        assigns(:ingredient).should be_a_new(Ingredient)
      end

      it "re-renders the 'new' template" do
        Ingredient.any_instance.stub(:save).and_return(false)
        post :create, :recipe_id => @recipe.id, :ingredient => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before :each do
      @ingredient = Factory.create :ingredient
    end

    describe "with valid params" do
      it "updates the requested ingredient" do
        Ingredient.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id, :ingredient => {'these' => 'params'}
      end

      it "assigns the requested ingredient as @ingredient" do
        put :update, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id, :ingredient => valid_attributes
        assigns(:ingredient).should eq(@ingredient)
      end

      it "redirects to the ingredient" do
        put :update, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id, :ingredient => valid_attributes
        response.should redirect_to(recipe_ingredient_path(@ingredient.recipe, @ingredient))
      end
    end

    describe "with invalid params" do
      it "assigns the ingredient as @ingredient" do
        Ingredient.any_instance.stub(:save).and_return(false)
        put :update, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id, :ingredient => {}
        assigns(:ingredient).should eq(@ingredient)
      end

      it "re-renders the 'edit' template" do
        Ingredient.any_instance.stub(:save).and_return(false)
        put :update, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id, :ingredient => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before :each do
      @ingredient = Factory.create :ingredient
    end

    it "destroys the requested ingredient" do
      expect {
        delete :destroy, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id
      }.to change(Ingredient, :count).by(-1)
    end

    it "redirects to the ingredients list" do
      delete :destroy, :recipe_id => @ingredient.recipe.id, :id => @ingredient.id
      response.should redirect_to(recipe_ingredients_url(@ingredient.recipe))
    end
  end

end
