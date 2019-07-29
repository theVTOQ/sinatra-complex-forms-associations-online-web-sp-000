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
    if !params[:pet].keys.include?("owner_ids")
      params[:pet]["owner_ids"] = []
    end

    pet = Pet.create(name: params["pet"]["name"])
    if !params["pet"]["owner_ids"].empty?
      pet.owner = Owner.find(params["pet"]["owner_ids"][0])
    elsif !params["owner"]["name"].empty?
      pet.owner = Owner.create(name: params["owner"]["name"])
    end

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
    pet.name = params["pet"]["name"]
    if !params["owner"]["name"].empty?
      pet.owner = Owner.create(name: params["owner"]["name"])
    elsif !params["pet"]["owner_ids"].empty?
      pet.owner = Owner.find(params["pet"]["owner_ids"][0])
    end
    binding.pry
    pet.save
    redirect to "pets/#{pet.id}"
  end
end
