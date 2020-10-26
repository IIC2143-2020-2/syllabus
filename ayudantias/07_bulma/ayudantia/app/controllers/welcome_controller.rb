class WelcomeController < ApplicationController
  def index
    @articles = Article.all
    @meals = Meal.all
    @categories = Category.all
  end

  def meal
    response = RestClient.get 'https://www.themealdb.com/api/json/v1/1/random.php'
    json = JSON.parse response
    puts json
    # if !json.nil?
    #   json['data'].map do |meal|
    #     Meal.create()
    #   end
    # else
    #   puts 'error seeding meals'
    # end
  end

  def meal_cat
    response = RestClient.get 'https://www.themealdb.com/api/json/v1/1/categories.php'
    json = JSON.parse response
    categories = json['categories']
    render
  end
end
