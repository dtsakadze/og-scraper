class Api::EntitiesController < ApplicationController
  def index
    per_page = params[:per_page]&.to_i || nil
    page = params[:page]&.to_i || 1

    entities = Entity.all.order(created_at: :desc).limit(per_page).offset(page * per_page.to_i)

    render json: { entities: entities }
  end

  def create
    entity = Entity.create(url: params[:url])

    res = entity.errors.any? ? { error: entity.errors.full_messages } : entity

    render json: res
  end
end
