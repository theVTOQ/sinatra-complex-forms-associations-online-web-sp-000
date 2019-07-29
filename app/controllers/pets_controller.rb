class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params["pet"])
    @pet.owners << Owner.create(name: params["owner"]["name"]) if !params["owner"]["name"].empty?
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])

    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end

    pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    @pet.owners << Owner.create(name: params["owner"]["name"]) if !params["owner"]["name"].empty?

    redirect to "pets/#{@pet.id}"
  end
end
