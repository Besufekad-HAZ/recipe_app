class PublicRecipesController < ApplicationController
     before_action :authenticate_user!

     def index
       @recipes = Recipe.where(public: true).order(created_at: :desc)
     end
   end

 # you can fix N+1 and add your other functionalities above
# def index
#     @recipes = Recipe.includes(:foods).where(public: true).order(created_at: :desc)
#   end




