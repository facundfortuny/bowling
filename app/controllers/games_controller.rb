class GamesController < ApplicationController
  def frame
    @game = Game.new(params, session[:frame])
    if @game.valid?
      @game.calc
    else
      flash[:error] = @game.error_message
    end
    session[:frame] = @game.over? ? nil : @game.frame
  end

  def new
    session[:frame] = nil
    redirect_to '/games'
  end

end