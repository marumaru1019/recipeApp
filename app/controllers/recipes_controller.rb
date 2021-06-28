class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  def index
    recipes = Recipe.select("id",
                            "title",
                            "making_time",
                            "serves",
                            "ingredients",
                            "cost"
                          ).order(created_at: :asc)
    render json: { recipes: recipes }
  end

  def show
    render json: { message: 'Recipe details by id', recipe: [@recipe] }
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: { message: 'Recipe successfully created!', recipe: [recipe] }
    else
      render json: { message: 'Recipe creation failed!', required: "title, making_time, serves, ingredients, cost" }
    end
  end

  def destroy
      recipe = Recipe.find_by(id: params[:id])
      if recipe
        recipe.destroy
        render json: { message: 'Recipe successfully removed!' }
      else
        render json: { message: "No Recipe found" }
      end
  end

  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      # WARNING: 先にシリアライザーを宣言しておかないと帰ってくるJSONの中に "serializer": {} というbodyが入ってしまう
      recipe_serializer = RecipeSerializer.new(recipe, serializer: RecipeSerializer )
      render json: { message: 'Recipe successfully updated!', recipe: [recipe_serializer] }
    else
      render json: { message: 'Recipe updating failed!', required: "title, making_time, serves, ingredients, cost" }
    end
  end

  private

  def set_recipe
        @recipe = Recipe.select("id",
                                "title",
                                "making_time",
                                "serves",
                                "ingredients",
                                "cost"
                              ).find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :making_time, :serves, :ingredients, :cost)
  end
end