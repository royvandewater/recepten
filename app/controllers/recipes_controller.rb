class RecipesController < ApplicationController

  respond_to :html, :json

  before_filter :find_recipe, :except => [:index, :new, :create]

  def index
    @recipes = Recipe.all

    respond_with @recipes
  end

  def show
    respond_with @recipe
  end

  def new
    @recipe = Recipe.new

    respond_with @recipe
  end

  def edit
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
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.json { head :ok }
    end
  end

  private
  def find_recipe
    @recipe = Recipe.find params[:id]
  end
end
