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
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    # binding.pry
    redirect "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    recip = Recipe.find(params[:id])
    recip.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    # binding.pry
    redirect "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end


end
