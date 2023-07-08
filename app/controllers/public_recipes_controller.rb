class PublicRecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.includes(:foods).where(public: true).order(created_at: :desc)
  end
end
