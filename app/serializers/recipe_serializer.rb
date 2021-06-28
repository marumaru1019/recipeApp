class RecipeSerializer < ActiveModel::Serializer
  attributes :title, :making_time, :serves, :ingredients, :cost
end
