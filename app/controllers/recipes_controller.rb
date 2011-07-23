class RecipesController < ApplicationController

  respond_to :html, :json

  def index
    @recipes = Recipe.all

    respond_with @recipes
  end

  def show
    @recipe = Recipe.find(params[:id])

    respond_with @recipe
  end

  def new
    @recipe = Recipe.new

    respond_with @recipe
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(params[:recipe])

    if @recipe.save
      respond_with @recipe, :status => :created, :location => @recipe, :notice => 'Recipe was successfully created.'
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.json { render :json => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        format.html { redirect_to(@recipe, :notice => 'Recipe was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.xml  { head :ok }
    end
  end
end
