class CharactersController < ApplicationController

  def index
    @characters = Character.all
  end

  def create
    @television_show = TelevisionShow.find(params[:television_show_id])
    @character = Character.new(character_params)
    @character.television_show = @television_show
    if @character.save
      flash[:notice] = "Success!"
      redirect_to @television_show
    else
      flash[:notice] = "Invalid answer!  Please make sure you have entered a unique character name and that you have entered an actor."
      render 'television_shows/show'
    end
  end

  def destroy
    @character = Character.find(params[:id])
    @television_show = @character.television_show
    if @character.destroy
      flash[:notice] = "Success!"
      redirect_to @television_show
    else
      flash[:notice] = "Character was not deleted."
      render 'television_shows/show'
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :actor, :description)
  end

end
