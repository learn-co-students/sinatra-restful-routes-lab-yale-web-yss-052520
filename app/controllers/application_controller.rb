class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = find_recipe
    @name= @recipe.name
    @ingredients = @recipe.ingredients
    @cook_time = @recipe.cook_time

    erb :show
  end

  get "/recipes/:id/edit" do
    @recipe = find_recipe
    @ingredients = @recipe.ingredients

    erb :edit
  end 

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = find_recipe
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = find_recipe
    @recipe.destory
    redirect "/recipes"
  end

  # helper find recipes
  def find_recipe
    Recipe.find(params[:id])
  end

end
