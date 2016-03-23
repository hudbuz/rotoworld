


class Rotoworld::Post

  attr_accessor :title, :headline, :impact, :source, :index

  @@all = []




  def initialize
    @@all<<self
  end

  def self.all
    @@all
  end







end