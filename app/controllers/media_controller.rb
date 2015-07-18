class MediaController < ApplicationController
  
  require 'will_paginate/array'
  before_filter :media_type, [:new]

  def index 
    @media = current_user.present? ? Media.where("user_id = ? or public = ?", current_user.id, true) : Media.where(public: true)
    @media = @media.videos if @media_type == Media::Type::Video
    @media = @media.images if @media_type == Media::Type::Image
    if params[:search]
      @media = @media.search(params[:search]).records.paginate(page: params[:page], per_page: 20)
    else
      @media = @media.paginate(page: params[:page], per_page: 20)
    end
  end

  def show
    @media = Media.find_by_id(params[:id])
  end

  def new
    @medium = current_user.medias.new()
  end

  def create
    @medium = current_user.medias.new(params[:media])
    if @medium && @medium.save
      redirect_to medium_path(@medium.id)
    else
      render 'new'
    end
  end

  def edit
    @medium = Media.find_by_id(params[:id])
  end

  def update
    @medium = Media.find_by_id(params[:id])
    if @medium && @medium.update_attributes(params[:media])
      redirect_to medium_path(@medium.id)
    else
      render 'edit'
    end
  end

  def destroy
    Media.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def media_type
    @media_type = params[:media_type].to_i if params[:media_type].present?
  end
end