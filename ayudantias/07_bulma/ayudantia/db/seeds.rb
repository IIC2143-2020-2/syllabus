# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.all

categories.each do |category|
  response = RestClient.get "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category.name}"
  json = JSON.parse response
  meals = json['meals']
  meals.each do |meal|
    Meal.create(name: meal['strMeal'], thumb: meal['strMealThumb'], mealId: meal['idMeal'])
  end
end
