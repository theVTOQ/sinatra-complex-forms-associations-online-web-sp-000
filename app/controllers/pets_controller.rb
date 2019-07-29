class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    pet = Pet.create(name: params["pet"]["name"])
    pet.owner = Owner.find(params["pet"]["owner_ids"][0]) if !params["pet"]["owner_ids"][0].empty?
    pet.owner = Owner.create(name: params["owner"]["name"])
    pet.save

    redirect to "pets/#{pet.id}"
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
    pet.update(params["pet"])
    pet.owners << Owner.create(name: params["owner"]["name"]) if !params["owner"]["name"].empty?
    pet.save

    redirect to "pets/#{pet.id}"
  end
end
