#=============================GameGrid, an in-console game===========================#


#DEVELOPERS: The Console Object
        
            $console={
                :log=>"Console/Log:",
                :errors=>"Error Log:"
            }
                #Console Functions
                def log(msg)
                    $console[:log]+="\n"+msg;
                end
                def error(msg, errorType=StandardError)
                    $console[:log]+="\n"+"Error: "+msg;
                    $console[:errors]+="\n"+msg;
                    raise errorType, msg
                end
                def errorA(msg)
                    error(msg,ArgumentError)
                end
                def checkA(arg,expclass)
                    errorA("Argument '#{arg}' is not a #{exptype}.") unless arg.is_a?( expclass);
                    log("Checking arguments using checkA method... input:#{arg} expected type:#{expclass}")
                end
                # Now using Begin/Rescue commands to fix IP issues
        $platsur="cp";
        begin 
        if ($platsur==="cp") then
            require 'socket'
            $ip_gateway=Socket::getaddrinfo(Socket.gethostname,"echo",Socket::AF_INET)
            $ip_socket=$ip_gateway[0]
            $ip=$ip_socket[3]
        elsif ($platsur.index("browser")!=-1) then
            $ip="192.168.1.1" #< This is your router ip, always
        else 
            $ip="64.233.187.99" #< This is one of Google's IP Pool
        end
                #Track the client OS
                def onWindows?
                    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
                end

                def onMac?
                    (/darwin/ =~ RUBY_PLATFORM) != nil
                end

                def onUnix?
                    !onWindows?
                end

                def onLinux?
                    onUnix? and not onMac?
                end
                
                def onOtherOS?
                    !onWindows?&&!onMac?&&!onLinux?&&!onUnix?
                end
                
                def getplatform
                    plat="other"
                    plat="windows" if onWindows?;
                    plat="mac" if onMac?;
                    #plat="unix" if onUnix?;
                    plat="linux" if onLinux?
                    plat="unix" if plat==="other"&&onUnix?
                    return plat
                end
                
                def getplat
                    return [getplatform, ENV["_system_version"]]
                end
                #Now we ignorantly :D scrape the client's username
                #but the scrape will fail if they are not in 
                # command line, so we will use begin/rescue to
                #resolve errors:
                def scrape_username
                    un=ENV["USER"] if onUnix?;
                    un=ENV["USERNAME"] if onWindows?||!onUnix?;
                    un="Great One" if un===nil||un.index("root")!=nil;
                    
                    return un
                
                end
#===== Variable Declarations ===
    #GG Code Variables
    $client_info={
        :platform=>getplat(),
        :ip=>"192.168.1.1",
        :username=>scrape_username,
        :syshash=>ENV
    }
    $begsurvdone=false;
    def beginning_survey
    puts "\n\n\n\n Hey "+scrape_username+", I see you have properly installed GameGrid! Don't just leave the GameGrid folder in "+ENV["PWD"]+"(downloads), why don't you move it to your Apps folder in /Applications or "+ENV["HOME"]+" for better access? Also, why don't you take this itty-bitty, 3-question survey before you start the game? Remember, we are testing for bugs, and this would really help. When the survey is finished, it will formulate some lettered code. Copy that and email it to tt2d [at] icloud [dot] com. Ready? The survey has begun!"
    puts "\n Where did you learn about GameGrid? (aka. Google Search, GitHub, flyer, friend told me, etc)"
    answer1=gets.chomp
    puts "\n From where did you install GameGrid? (aka. GitHub, I locally had it, friend sent the files in an email, download site, etc)"
    answer2=gets.chomp
    puts "\n What out of these 5 categories do you describe yourself as: developer, gamer, tester, kid, parent? (you can type anything else if these  don't suit you)"
    answer3=gets.chomp
    
    
    arr=[answer1,rand(99999999999),answer2,rand(99999999999),answer3,rand(999999999),rand(12112121),"-/fhih983293820-",$ip]
    arrs=arr.to_s
    puts "Thank you! See the code below? Copy that and email it to tt2d [at] icloud [dot] com. Thanks so much! To start playing, type play."; begsurvdone=true; 
    return arrs
    end
    $githubaddr="http://www.github.com/Adihaya/GameGrid/?ref=learnstreet.com/scratchpad/ruby?ggplay";
    $modechoices={ :player=>0, :developer=>1, :administrator=>2 }
    $mode=$modechoices[:developer]
        
        $client_info[:ip]=$ip;
        rescue LoadError
        $platsur="browser (error)";
        log("RESCUED ERROR: IP Pooling (Socket:getaddrinfo): platform communicated as 'cp' but detected as browser")
        retry 
        end
        
    # Important Variables
        $lives=5; $energy=100; $altitude=10;
        $tutorialon=true;
    #System Constants
        $cursession=1; $playid=rand(9^5);  
        $credits="Game created completely by Adihaya. Help in testing comes from VasantVR.\n See out GitHub address for all our GameGrid code:\n'"+$githubaddr+"'"
            
 #A Point is an area on the gamegrid
class Point
    #Attributes of your point
    attr_accessor :x, :y, :object, :gtype
    attr_reader :id, :ground
    
    #Ifdo: What might happen if you do <action>?
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

class Grid 
attr_accessor :points, :center, :origin, :xmin, :xmax, :ymin, :ymax, :area, :xdif, :ydif, :ground; attr_reader :id, :visualizer
@id=rand()
    def [](x,y)
        xypair=[x,y]
        return @points[xypair]
    end
     def []=(x,y,to) #Make sure to actually syntax like this: [x,y]=to
        xypair=[x,y]
        @points[xypair]=to;
    end
    def update
        @area=(@xmax-@xmin+1)*(@ymax-@ymin+1)
        @xdif=(@xmax-@xmin+1);@ydif=(@ymax-@ymin+1)
    end
    def updpoints(gr=@ground)
        puts "Updating points on grid...\n GRID UPDATE NOTICE: You are using updpoints, the latest version of the official Grid Point Updater!"
        update()
        begin
        keepsetting1=true; xnum=@xmin; ynum=@ymin; xmax=@xmax; ymax=@ymax; xnumy=@xmin; 
        while (keepsetting1===true) do
                
            ynumy=@ymin;
            keepsetting2=true;
            while (keepsetting2===true) do
                curpoint=Point.new(xnum,ynumy,gr);
                pair=[xnum,ynumy]
                @points[pair]=curpoint
                ynumy+=1
                if (ynumy>ymax)
                    keepsetting2=false; break;
                end  
            end
            xnum+=1
            if (xnum>xmax)
                keepsetting1=false; break;
            end
        end
        if (@area===@points.length) then; log("Grid:updpoints:success"); else; error("Grid:updpoints:failed grid.area='#{@area}', grid.points.length='#{@points.length}', area!=points.length",IndexError); end
        rescue IndexError
        @area=@points.length
        retry
        end
        
    end
    def initialize(xmin,xmax,ymin,ymax,origin=[0,0],center=[0,0],ground="asphalt")
        begin
        xmax-=1; ymax-=1;
        @id=rand()
        @xmin=xmin;@xmax=xmax;@ymin=ymin;@ymax=ymax;
        @area=(@xmax-@xmin+1)*(@ymax-@ymin+1)
        @xdif=(@xmax-@xmin+1);@ydif=(@ymax-@ymin+1)
        @origin=origin
        @center=center
        @points={};
        @ground=ground
        @visualizer="run visualize method on this grid to set visualizer"; @oldvisualizers=[]
        updpoints()
        rescue
        xmin=0,xmax=0,ymin=0,ymax=0,ground="asphalt"
        retry
        end
        puts "Initialized Grid."
    end
    def visualize(point=nil)
        puts "Converting Point elements to Arrays..."
        plotmarks=point if point.class===Array;
        plotmarks=[point.x,point,y] if point.class===Point;
            xdif=@xdif; ydif=@ydif
            xline="|"+" o "*xdif+"|\n"
            yplnum=@ymax+1; full = "   "+"___"*(xdif)+"\n"
            while(yplnum>@ymin)
                curd=""
                curd=" " if (yplnum<10&&yplnum>(-1))
                full+=(yplnum.to_s+curd+xline); yplnum-=1;
                break if (yplnum<=@ymin);
            end
        #full=xline*ydif
            xplotters = "   "; xplnum=@xmin
        puts "Measuring plot size... Calculating Areas..."
        while(xplotters.length/3<=xdif+1)
            xplotters+=" "+xplnum.to_s+" ";
            xplnum+=1
            break if xplnum>=@xmax;
        end
        puts "Processing visualization..."
            full+="   "+"___"*(xdif)+"\n";full+=xplotters
        @visualizer=full; @oldvisualizers.push(full)
                        puts full
    end
    
end

$battle = {
    'target'=>:knee,
    'opponent'=>{'name'=>:bandit, 
                'lives'=>3,
                'energy'=>50,
                'active'=>true,
                'weapon'=>:stick,
                'weakpoint'=>:knee},
    'type'=>:closed_combat
}
    
    
    
#Create Directories
def makedir(path)
create_dirs=true
begin
if create_dirs===true then
require "fileutils"


FileUtils.mkdir_p(path) unless File.exists?(path)
end
rescue LoadError
puts "Error: access denied";create_dirs=false; retry
end
end
file_main=true;begin
#if (file_main===true) then
#makedir("~/.gg_internals/") 
# Create a new file for GG and write to it  
#File.open('~/.gg_internals/main.rb', 'w') do |f2|  
 # # use "\n" for two lines of text  
  #f2.puts "scores=[0]"  
#end  
#File.open('~/.gg_internals/welcome.html', 'w') do |f2|  
  # use "\n" for two lines of text  
#  f2.puts "<!DOCTYPE html><html><body>Hello, we see that you've now visited GameGrid Internals. This file 'welcome.html' was stored in '~/.gg-internals/', the official folder of GameGrid gadgets, tools, and internal algorithms. Feel free to mess around with everything, but be slightly cautious about what you do. Take a look around! <br><br>Thanks, The GG Team</body></html>"
#end  
#end
rescue
file_main=false
puts "...."; retry;
end




#Create $loc, the point you are standing on (current location)
$loc=Point.new(1,1,'asphalt'); puts "^ $loc creation".center(50)
#Create $grid, the local point grid
puts "Creating $grid...".center(50); puts "===Grid Point Initialization===".center(50)
$grid=Grid.new(0,10,0,10)
# ============= Commands ========
def attack(targ)
    error("target needs to be Symbol (:target)",ArgumentError) if targ.class!= Symbol;
    $battle['target']=targ
    targets=[:knee,:hands,:lhand,:rhand,:rleg,:lleg,:eyes,:mouth,:nose,:face,:head,:lap,:thighs,:stomach,:tummy]
    
end
def webhost!
    puts "Your host Internet Protocol Address (IP) is: \n"+$ip;
end
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

def email_to_name(email)
  name = email[/[^@]+/]
  name.split(".").map {|n| n.capitalize }.join(" ")
end

#============== END Commands =====
#Play: start the game tutorial
def play 
if ($tutorialon===true) then
    $loc.x=1; $loc.y=1; # Reset current loc
    puts "Hello, my friend "+$client_info[:username]+", I've been waiting to show you this very cool computer video game called GameGrid. The weird part is, you don't see anything, you just type commands and stuff! Here, why don't we begin the tutorial.\n\n\n"
    puts "GameGrid - Official Tutorial!".center(75);
    puts "Welcome to GameGrid, the in-console game. You are currently standing on something called a Point. You are standing "+$loc.this
    puts "Points are locations on the gamegrid. You can also move around by executing             commands. Why don't you try typing walk(1,0) ?"
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
        p2over=true if ($lives===4.5&&$altitude===2);
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
    end
    if (p3over===true) then
        puts "\n\n\n Now let's learn about some (a bit boring) stuff. Lets learn about system constants. These constants are system-specified. One of them is called credits. Credits are not very important to you, but they tell you who helped create GameGrid. Credits can be accessed via the credits? command. Commands that end with the ? sign are system constants. Another system constant is log and errors. The log shows system developer operations, errors shows errors that occured in the system. Logs are accessed with the log? command, errors with the errors? command. Why don't you check out the credits, by typing credits? below:\n"
        command=gets.chomp; p4over=false;
        eval(command)
        p4over=true if command.index('credits?')!=-1;
        puts "Are you sure you typed 'credits?' exactly? Don't type for an other system variable like log?, as we wanted you to type for the credits variable. Type play to retry." if p4over===false;
    end
    if (p4over===true) then
        puts "Okay, one last, very critical thing before something awesome and fun: $loc and $grid. These 2 commands are very powerful. They are called 'codejectors' or CJ's. The $loc command outputs a CJ classified as a Point, which is an area on the GameGrid. It represents your current location. The $grid command outputs a CJ, classified as a Grid. It is the actual GameGrid, with tens to thousands of associated points. When you command for these CJs, they will show you some code. You may not understand it, but that doesn't matter. You have to utilitize the 'methods' on these CodeJectors. Methods are ways to uncover info, or do a function. The $loc.this function shows you info about where you're at. $loc.x and $loc.y show you your coordinates. If you command this: $grid[x,y] and replace x and y with valid coordinate numbers, it will  show you a CJ for the point on that coordinated area.\n\nWhy don't you type $grid.points, just to see the code (code means, basically your computer's native language) on that CJ that stores the grid's points?"
        command=gets
        if (command.index("$grid.points")!=-1) then
            puts $grid.points
            puts "Great job! See all that code? It may seem weird to you, but trust me, once you learn a code language like Ruby or JavaScript, you'll see how simple and effective it is. Let's move on to new stuff, man!"
            else; return "I don't think you commanded for $grid.points. Try again.";         
        end
        
        
        puts "\n\nYou're a fast learner! But the most important thing we need to learn: battles. Let's begin our battle tutorial. \n\n Pretend you're walking on the street, and you see a bandit with his weak weapon: a stick. It's time for you to learn how to battle. Your weapon currently: kitchen knife. Okay, before you get noticed, jab him on the knee. Type 'attack(:knee)'."
        command=gets; p5_1over=false;
        if(command.index("attack")!=-1&&command.index(":")!=-1) then
           p5_1over=true
        else
            return "Oh no! We couldn't parse (understand) your command. The bandit noticed you and hit you in the eye. You immediately fainted. Please try the tutorial again."
        end
    end
    
    if (p5_1over===true) then
        puts "Good job! He immediately fell down, and started examining his wound on his #{$battle[:target]}. Oh, no! He noticed you! He drops his weapon in awe. Quick! Get his weapon! Type pickup(:weapon) to grab his beating stick."
        command=gets; p5_2over=false; 
        if (command.index("pickup")!=-1&&command.index(":weapon")!=-1) then
            p5_2over=true;
        else; return "Oh no! We couldn't parse (understand) your command. The bandit caught you and hit you in the eye. You immediately fainted. Please try the tutorial again."
        end
    end
    if (p5_2over===true) then
        $tutorialon=false;
        log("Tutorial completed.")
        puts "Awesome! Now your neighbors have called the police. The job has been done. You know how to walk, jump, attack, get variables, and much more. Your first mission is done. Now get ready for some more awesomeness. The SpyForce have hired you! You now go by the secretive name, Agent X, and you must keep your real identity, "+scrape_username+", away from the public. Congratulations! You have successfully completed the tutorial.\n\n NOTICE: Hey "+scrape_username+", I haven't seen you in a while, so I might not remember your name right. Why don't you type your name or email, so I can recognize you right? (if you don't want to, type quit)"
        nm=gets.chomp
        return "Good job on finishing that tutorial!" if nm.index("quit")!=-1;
        ENV['USER']=email_to_name(nm);
        ENV['USERNAME']=email_to_name(nm);
        puts "Hey, thanks "+ENV['USER']+", for reminding me of yourself! Continue doing awesome on GameGrid! Congrats for swiftly finishing up that tutorial!!!"
    else; return "Oh no! We couldn't parse (understand) your command. The bandit caught you and hit you in the eye. You immediately fainted. Please try the tutorial again."; 
    end
if ($tutorialon===false) then
    puts "DEVProto"
    log("Tutorial access denied: $tutorialon=false")
   
end
end
if ($tutorialon===false) then
    puts "DEVProto"
    log("Tutorial access denied: $tutorialon=false")
   
end 
end




beginning_survey() unless $begsurvdone===true;
