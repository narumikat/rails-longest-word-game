require 'open-uri'

class GamesController < ApplicationController
  def new
    rand_grid = Array('A'..'Z')
    @letters = Array.new(10) { rand_grid.sample}
  end
  
  def score
    @input = (params[:word] || "").upcase
    @letters = params[:letters]
    @answer_grid = word_in_grid?(@input, @letters)
    @english_word = english_word?(@input)
    # raise
  end

  private

  def word_in_grid?(word, grid)
    # word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
    word.chars.all? { |letter| grid.include?(letter) }
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
    letters_serialized = URI.open(url).read
    letters = JSON.parse(letters_serialized)
    letters['found']
  end
end
