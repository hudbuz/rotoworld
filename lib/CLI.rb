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
    Rotoworld::Scraper.new.get_posts
    show_posts

    puts "Would you like to refresh or exit?"
    input = gets.strip
    if input.downcase == "refresh"
      call
    elsif input.downcase == "exit"
      system("clear")
      puts "Thanks for visiting."
      sleep(5)
      
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
          puts 
          puts "Would you like to move on or exit? Or type fantasy to make a trade! Or type bet to go to DraftKings!"
          input3 = gets.strip
          if input3.downcase == "exit"
            break
          elsif input3.downcase == "fantasy"
            Launchy.open("http://games.espn.go.com/frontpage/football")
          elsif input3.downcase == "bet"
            Launchy.open("https://www.draftkings.com/")
          elsif input3.downcase == "move on"
            nil
          elsif input3.downcase == "refresh"
            call
          else
            nil
          end
        elsif input2.downcase == "refresh"
          call
        elsif input2.downcase == "exit"
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



