class IngredientsController < ApplicationController

  respond_to :html, :json

  before_filter :find_recipe
  before_filter :find_ingredient, :except => [:index, :new, :create]

  def index
    @ingredients = @recipe.ingredients.all

    respond_with @ingredients
  end

  def show
    respond_with @ingredient
  end

  def new
    @ingredient = @recipe.ingredients.build

    respond_with @ingredient
  end

  def edit
  end

  def create
    @ingredient = @recipe.ingredients.build(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to edit_recipe_path(@recipe), :notice => 'Ingredient was successfully created.' }
        format.json { render :json => @ingredient, :status => :created, :location => recipe_path(@recipe) }
      else
        format.html { render :action => "new" }
        format.json { render :json => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        format.html { redirect_to(recipe_ingredient_path(@recipe, @ingredient), :notice => 'Ingredient was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to(recipe_ingredients_url(@recipe)) }
      format.xml  { head :ok }
    end
  end

  private
  def find_recipe
    @recipe = Recipe.find params[:recipe_id]
  end

  def find_ingredient
    @ingredient = @recipe.ingredients.find(params[:id])
  end
end
