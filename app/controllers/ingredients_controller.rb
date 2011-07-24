class IngredientsController < ApplicationController
  before_filter :find_recipe
  before_filter :find_ingredient, :except => [:index, :new, :create]

  def index
    @ingredients = @recipe.ingredients.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ingredients }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ingredient }
    end
  end

  def new
    @ingredient = @recipe.ingredients.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ingredient }
    end
  end

  def edit
  end

  def create
    @ingredient = @recipe.ingredients.build(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to(@ingredient, :notice => 'Ingredient was successfully created.') }
        format.xml  { render :xml => @ingredient, :status => :created, :location => @ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        format.html { redirect_to(@ingredient, :notice => 'Ingredient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to(ingredients_url) }
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
