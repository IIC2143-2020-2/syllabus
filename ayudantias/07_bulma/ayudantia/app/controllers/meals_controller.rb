class MealsController < ApplicationController
  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to @meal
    else
      render 'new'
    end
  end

  def new
    @meal = Meal.new
  end

  def index
    @meals = Meal.all
  end

  def update
    @meal = Meal.find(params[:id])

    if @meal.update(meal_params)
      redirect_to @meal
    else
      render 'edit'
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path
  end

  def show
    @meal = Meal.find(params[:id])
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :thumb, :mealId)
  end
end
