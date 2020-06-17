class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do 
    @recipes = Recipe.all()
    erb :index
  end

  get '/recipes/new' do 
    erb :new 
  end

  get '/recipes/:id' do 
    @recipe = get_recipe(params)
    erb :show
  end

  get '/recipes/:id/edit' do 
    @recipe = get_recipe(params)
    erb :edit
  end

  post '/recipes' do 
    recipe = Recipe.create(
      name: params[:name], 
      ingredients: params[:ingredients], 
      cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  patch '/recipes/:id' do 
    recipe = get_recipe(params)
    recipe.update(
      name: params[:name], 
      ingredients: params[:ingredients], 
      cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do 
    Recipe.delete(params[:id])
    redirect "/recipes"
  end

  def get_recipe(params)
    Recipe.all.find(params[:id])
  end
end
