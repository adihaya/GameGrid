require './D2S2/levels'
include Levels

class Game

    def run()
    next_room = @start
	
	while true
	  puts "\n----------"
	  puts
	  room = method(next_room)
	  next_room = room.call()
	end
  end
  
  def death()
    deathline= @quips[rand(@quips.length())]+"\n A Time Warp has been activated, and you've been pushed back to Sector 1 of the 2nd Dimension. Good luck next time."
      puts deathline
      $dimension=2; $sector = 1; 
	   play()
  end
  def initialize(start)
    @quips = [
	  "You died, and thus ends the world's best hope for peace.",
	  "The terrorists win, and humanity loses.",
	  "The greatest warrior of modern times has perished...",
	  "It's a shame you won't live long enough to see the terrorists take over the world."
	  ]
	  
	@start = start
	
	def forgot_name()
	  puts()
	  puts "OK wise guy, why don't you come back when you remember your name!"
	  $sector=1;
	end
	
	def no_answer()
	  puts()
	  puts "You will need at least elementary school-level English to be able"
	  puts "to defeat the terrorists."
	  $sector=1;
	end
	def enter_name
        puts <<TEXT



For actions, use the first 2 letters of the verb (action name) to do the action. 
Usually, actions and their execution keywords are denoted like this: [br]eak
This example means, to break, type br and hit enter.


=========BEGIN=========

TEXT
@name=scrape_username;	  
return :holding_room
    
  end
  
  
end
end

a_game = Game.new(:enter_name).run()

  
