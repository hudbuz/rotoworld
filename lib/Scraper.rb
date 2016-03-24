require 'open-uri'
require 'pry'
require 'nokogiri'
require 'launchy'




class Rotoworld::Scraper

  attr_accessor :title, :headline, :source, :impact, :index
  def get_posts 


    doc = Nokogiri::HTML(open("http://www.rotoworld.com/playernews/nfl/football-player-news/?ls=roto:nfl:gnav&rw=1"))
    player_set = doc.css("div.RW_pn div.pb")
    index = 1


    player_set.each do |player|

      post = Rotoworld::Post.new

      post_title_info = player.css("div.headline div.player").text
      player_name = player.css("div.headline div.player a").text
      player_position_team = post_title_info.match(/- .+\s+-+\s+.+[st$]/)
      post.title = "#{player_name}#{player_position_team}"
      post.headline = player.css("div.report p").text
      post.impact = player.css("div.impact").first.text.strip
      post.source = player.css("div.info div.source a").attr("href").value
      post.index = index
      index +=1
   
    end
    
  end
end
