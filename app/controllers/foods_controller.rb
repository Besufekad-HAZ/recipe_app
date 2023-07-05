class FoodsController < ApplicationController
  def index
    @foods = current_user.foods.order("#{sort_column} #{sort_direction}")
  end

  def new
    @food = current_user.foods.build
  end

  def create
    @food = current_user.foods.build(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy

    redirect_to foods_path, notice: 'Food was successfully destroyed.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def sortable_columns
    %w[name measurement_unit price quantity]
  end

  def sort_column
    sortable_columns.include?(params[:sort]) ? params[:sort] : 'name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
