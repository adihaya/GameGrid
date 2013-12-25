#=============================GameGrid, an in-console game===========================#


#===== Variable Declarations ===
    # Important Variables
        $lives=5; $energy=100; $altitude=10;
        $tutorialon=true;
    #System Constants
        $cursession=1; $playid=rand(9^5);  
        $credits="Game created completely by Adihaya. Help in testing comes from VasantVR."
            #The Console Object
            $console={
                :log=>"Console/Log:",
                :errors=>"Error Log:"
            }
                #Console Functions
                def log(msg)
                    $console[:log]+="\n"+msg;
                end
                def error(msg)
                    $console[:log]+="\n"+"Error: "+msg;
                    $console[:errors]+="\n"+msg;
                end
 
 #A Point is an area on the gamegrid
class Point
    #Attributes of your point
    attr_accessor :x, :y, :object, :gtype
    attr_reader :id, :ground
    
    #Ifdo: What might happen if you do (action)?
    def ifdo(action)
    actionlist=["fall","jump","swim","sit"]
    resultsperType={
        "rocksolid"=>['You will lose 1/2 lives, lose 8 altitude', 'You will lose 5 energy, gain 3 altitude', 'Not possible','You will lose 4 altitude, lose 2 energy'],
        "softy"=>['You will lose 8 altitude','You will lose 5 energy, gain 3 altitude', 'Not possible', 'You will lose 4 altitude, lose 1 1/2 energy'],
        "dangerous"=>['You will lose 3 1/2 lives, lose 8 altitude', 'You will lose 10 energy, gain 3 altitude', 'You will lose 4 1/2 lives','You will lose 4 altitude, lose 2 1/2 lives']
    }
    if (resultsperType.include?(@gtype)===false) then
        raise "Ground Type does not comply"
    end
    myresults=resultsperType[@gtype]
    if (actionlist.include?(action)===false) then
        raise "Action type does not comply"
    end
    ordernum=actionlist.index(action)
    result=myresults[ordernum]
    log(self.to_s+": .ifdo function called, result='"+result+"'")
    return result
    end
    
    #SetGType: What type of ground am I standing on?
    def setGType
        case @ground;
        when "asphalt", "rock", "concrete", "wood"
            @gtype="rocksolid"
        when "carpet", "bed", "mat"
            @gtype="softy"
        when "lava", "magma", "fire", "spikes", "poison"
            @gtype="dangerous"
        end
        return @gtype;
    end
    
    #Result: Do (action) for me.
    def result(action)
    actionlist=["fall","jump","swim","sit"]
    resultsperType={
        "rocksolid"=>['$lives-=0.5; $altitude-=8', '$energy-=5; $altitude+=3', '','$altitude-=4; $energy-=2'],
        "softy"=>['$altitude-=8','$energy-=5; $altitude+=3', '', '$altitude-=4, $energy-=1.5;'],
        "dangerous"=>['$lives-=3.5; $altitude-=8', '$energy-=10; $altitude+=3', '$lives-=4.5','$altitude-=4; $lives-=2.5']
    }
    if (resultsperType.include?(@gtype)===false) then
        raise "Ground Type does not comply"
    end
    myresults=resultsperType[@gtype]
    if (actionlist.include?(action)===false) then
        raise "Action type does not comply"
    end
    ordernum=actionlist.index(action)
    result=myresults[ordernum]
    puts ifdo(action)
    eval(result)
    end
    #Ground=: Set the ground to any ground area (aka. rock)
    def ground=(target)
        @ground=target
        setGType()
    end
    
    #Initialize: Set the required variables in the beginning of time
    def initialize(x,y,ground,object=nil)
    @id=rand(999999999)
        @x=x
        @y=y
        @ground=ground
        if object!=nil then
           @object=object 
        else
            @object=nil
        end
        obj=object
        if (obj===nil) then
            obj=" no objects"
        end
        setGType();
        puts "Point created at #{@x}, #{@y}, on #{@ground}, with"+obj
    end
    def getloc
        return 'hi'
    end
    
    #This: Basic info about this point
    def this
    if (@object===nil) then
        return 'at '+@x.to_s+', '+@y.to_s+', on '+@ground+', with no objects found.'
    else
        return 'at '+@x.to_s+', '+@y.to_s+', on '+@ground+', with a '+@object+' found on the ground.'
    end
    end
end

#Create $loc, the point you are standing on (current location)
$loc=Point.new(1,1,'asphalt')
# ============= Commands ========

#Walk: walk around the grid
def walk(up,right)
    $loc.x+=up
    $loc.y+=right
    puts "Walked #{up} points up, and #{right} points to the right. Standing on #{$loc.x}, #{$loc.y}. Location: #{$loc.this}"
end
fell=false;

#Fall: fall down onto the ground (ouch)
def fall() 
$loc.result("fall")
fell=true;
puts "\n"
end

#Lives!: access the lives variable
def lives!
    puts $lives;
end 

#Energy!: access the energy variable
def energy!
puts $energy
end
#Altitude!: access the altitude variable
def altitude!
puts $altitude
end



#SystemConstant Access commands
def credits?
puts $credits
end
def log?
puts $console[:log]
end
def errors?
puts $console[:errors]
end
def getconsole?
puts $console
end

#============== END Commands =====
#Play: start the game tutorial
def play 
if ($tutorialon===true) then
$loc.x=1; $loc.y=1; # Reset current loc
puts "Welcome to GameGrid, the in-console game. You are currently standing on something called a Point. You are standing "+$loc.this
puts "Points are locations on the gamegrid. You can also move around by executing commands. Why don't you try typing walk(1,0) ?"
command=gets
eval(command)
if $loc.x===2 then
    p1over=true;puts "\n Congrats! Did you see that? You moved up on the GameGrid, by 1 point. Using the walk(up,right) command lets your player abstractly walk the grid."; 
else
    p1over=false; return "Are you sure you typed walk(1,0) exactly? I don't think so. Remember to type EXACTLY what is shown. Type play to retry the tutorial."; 
end
if (p1over===true) then
fell=false;
    $loc.ground="asphalt"
    puts "Okay, now let's talk about the ground. The ground you currently stand on, is asphalt. You might be thinking, asphalt's just fine. But try this: type command fall() and watch the results."
    $lives=5; $altitude=10; $energy=100;
    command=gets
    eval(command)
    p2over=false;
    p2over=true if ($lives===4.5&&$altitude=2);
end
if (p2over===true) then
    puts "Excellent! You really know what you're doing."
    puts "Okay, you know how to walk and fall. You might think you already know how to do everything. But in this game... in this dimension.... "
    puts "You... Are... BLIND"
    puts "\n No, I mean it. In GameGrid, you conquer with a disadvantage: you can't see. You have to do actions like walking, by commanding you're loyal servant (his life is to help you with your blindness). "
    puts "But... the goal of this journey... the reason you're playing here... is to overcome this disadvantage. To do so, you must capture The Royal Eyes from the evil Zuki. When you do so, you can see, better than anyone else (and win the game). But... we're not there yet. So let's get started, with more commands! (Ugh, this is boring, you might be thinking, but it'll help you lots)"
    puts "\n Okay, lets learn about some important variables in your life. To access important variables, you attach a ! sign after it's name. One of the important variables, is lives. This is how many lives you have left. You start out with 5, and can have 5 as a maximum. To access this variable, you have to command lives! . More important variables include energy and altitude. Energy is how much energy you have in you. Activities (commands) like jumping, use up energy. You start with and have a max of 100 energy. Altitude is how high your head is from the ground. Sounds boring, but knowing the altitude helps in battles. To command for energy and altitude, you command energy!, and altitude!. Why don't you try commanding for one of these important variables?"
    command=gets.chomp+""
    eval(command); p3over=false;
    if (command.index("!")!=nil) then
        p3over=true;
        puts "\n\nYay! You did it! Typing commands for variables like the one you typed: "+command+" helps in the future."
    end
if (p3over===true) then
    puts "\n\n\n Now let's learn about some (a bit boring) stuff. Lets learn about system constants. These constants are system-specified. One of them is called credits. Credits are not very important to you, but they tell you who helped create GameGrid. Credits can be accessed via the credits? command. Commands that end with the ? sign are system constants. Another system constant is log and errors. The log shows system developer operations, errors shows errors that occured in the system. Logs are accessed with the log? command, errors with the errors? command. Why don't you check out the credits, by typing credits? below:\n"
    command=gets.chomp; p4over=false;
    eval(command)
    p4over=true if command.index('credits?')!=-1;
    puts "Are you sure you typed 'credits?' exactly? Don't type for an other system variable like log?, as we wanted you to type for the credits variable. Type play to retry." if p4over===false;
end
if (p4over===true) then
    puts "\n\nYou're a fast learner! Okay, we'll learn a few last things before we get to freestyle commands. Which reminds me of command center. The command center, is the place to utilize these commands you've learned. You can easily access it by commanding 'freestyle'. But the most important thing we need to learn: battles. Let's begin our battle tutorial. \n\n Pretend you're walking on the street, and you see a bandit with his weak weapon: a stick. It's time for you to learn how to battle. Your weapon currently: kitchen knife. Okay, before you get noticed, jab him on the knee. Type 'attack(:knee)'."
    command=gets; p5_1over=false;
    if(command.index("attack")!=-1&&command.index(":knee")!=-1) then
        p5_1over=true
    else
        return "Oh no! We couldn't parse (understand) your command. The bandit noticed you and hit you in the eye. You immediately fainted. Please try the tutorial again."
    end
end
if (p5_1over===true) then
    puts "Good job! He immediately fell down, and started exxamining his wound. Oh, no! He noticed you! He drops his weapon in awe. Quick! Get his weapon! Type pickup(:weapon) to grab his beating stick."
    command=gets; p5_2over=false; 
    if (command.index("pickup")!=-1&&command.index(":weapon")!=-1) then
        p5_2over=true;
    else; return "Oh no! We couldn't parse (understand) your command. The bandit caught you and hit you in the eye. You immediately fainted. Please try the tutorial again."
    end
end
if (p5_2over===true) then
    puts "Awesome! Now your neighbors have called the police. The job has been done. You know how to walk, jump, attack, get variables, and much more. Your first mission is done. Now get ready for some more awesomeness. You have successfully completed the tutorial."
else; return "Oh no! We couldn't parse (understand) your command. The bandit caught you and hit you in the eye. You immediately fainted. Please try the tutorial again."; 
end
end
end
end