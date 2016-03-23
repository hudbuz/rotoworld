require 'open-uri'
require 'pry'
require 'nokogiri'
require 'launchy'




class Rotoworld::CLI 

  attr_accessor  :title, :headline, :source, :impact, :index


  def call
    space
    puts "Welcome to Rotoworld NFL - Player News"
    puts "______________________________________"
    get_posts
    show_posts

    


    puts "Would you like to read again or exit?"
    input = gets.strip
    if input.downcase == "read" || input == "read again"
      call
    elsif input.downcase == "exit"
      puts "Thanks for visiting."
      
    end
  end


  def get_posts 


    doc = Nokogiri::HTML(open("http://www.rotoworld.com/playernews/nfl/football-player-news/?ls=roto:nfl:gnav&rw=1"))
    player_set = doc.css("div.RW_pn div.pb")
    index = 1


    player_set.each do |player|

      post = Rotoworld::Post.new

      post_title_info = player.css("div.headline div.player").text
      player_name = player.css("div.headline div.player a").text
      player_position_team = post_title_info.match(/- .+\s+-+\s+.+[st$]/)
      post_title = "#{player_name}#{player_position_team}"
      post.title = post_title
      post_short = player.css("div.report p").text
      post.headline = post_short
      post_long = player.css("div.impact").first.text.strip
      post.impact = post_long
      post_source = player.css("div.info div.source a").attr("href").value
      post.source = post_source
      post.index = index
      index +=1
   
    end
    

    

  end

  def show_posts

   
    puts "Here are the most recent updates!"
    puts "Type refresh at any time to refresh the newsfeed!"
    puts "___________________________________"
    sleep(5)

    
    Rotoworld::Post.all.each do |post|
      system("clear")
      puts "----------------------------------"
      puts post.index.to_s + ". " + post.title
      puts "----------------------------------"
      puts post.headline
      puts ""
      puts ""
      puts "Would you like to read more? (y/n) "
      input = gets.strip
      if input.downcase == "yes" || input.downcase == "y"
        puts ""
        puts ""
        puts post.impact
        puts ""
        puts ""

        puts "Would you like to view the source? (y/n) "
        input2 = gets.strip
        if input2.downcase == "yes" || input2.downcase == "y"
          Launchy.open(post.source)
          sleep(5)
          puts "Would you like to move on or exit?"
          input3 = gets.strip
          if input3 == "exit"
            break
          elsif input3 == "move on"
            nil
          elsif input3 == "refresh"
            call
          else
            nil
          end
        elsif input2 == "refresh"
          call
        elsif input2 == "exit"
          break
        end
        
      elsif input.downcase == "n" || input.downcase == "no"
        nil
      
      elsif input.downcase == "refresh"
        call
      elsif input.downcase == "exit"
        break
      else
        nil
      end


    end
  end

  def space
    20.times do
      puts ""
    end
  end

end
