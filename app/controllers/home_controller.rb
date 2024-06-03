class HomeController < ApplicationController
  def index
    @tips = Tip.all
    @exercises = Exercise.all
    @professionals = Professional.all
  end
end
