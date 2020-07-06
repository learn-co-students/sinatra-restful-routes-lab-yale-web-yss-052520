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
    erb :show
  end

  post '/recipes' do 
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id/edit' do 
    @recipe = find_recipe
    erb :edit
  end
  
  patch '/recipes/:id' do
    @recipe = find_recipe
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = find_recipe
    @recipe.destroy
    redirect '/recipes'
  end

  # helper find method
  def find_recipe
    Recipe.find(params[:id])
  end
  
end
