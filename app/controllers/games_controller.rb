require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    grid = params[:grid]
    guess = params[:word]

    if includes?(guess.upcase, grid)
      if english?(guess)
        @score = "Congrats! #{guess.upcase} is a valid word!"
      else
        @score = "Sorry, but #{guess.upcase} does not exist in the English language!"
      end
    else
      @score = "Sorry, but #{guess.upcase} is not formed of the provided letters in #{grid}!"
    end
    @score
  end

  def includes?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english?(guess)
    response = open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
    json['found']
  end

end
