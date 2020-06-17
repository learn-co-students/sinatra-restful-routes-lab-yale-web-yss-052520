class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end
  
  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes/:id' do
    @recipe = get_recipe
    erb :show
  end
  
  get '/recipes/:id/edit' do
    @recipe = get_recipe
    erb :edit
  end
  
  post '/recipes' do 
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end
  
  patch '/recipes/:id' do
    # binding.pry
    recipe = get_recipe
    recipe.update(params[:recipe])
    
    redirect "/recipes/#{recipe.id}"
  end
  
  delete '/recipes/:id' do
    recipe = get_recipe
    recipe.delete
    
    redirect "/recipes"
  end
  
  def get_recipe
    Recipe.find(params[:id])
  end

end
