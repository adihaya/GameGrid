#=============================GameGrid, an in-console game===========================#


#DEVELOPERS: The Console Object
        
            $console={
                :log=>"Console/Log:",
                :errors=>"Error Log:"
            }
                #Console Functions
                def log(msg)
                    $console[:log]+=Time.now.to_s+":   "+msg;
                end
                def error(msg, errorType=StandardError)
                    log("ERROR - "+msg+" ET: "+errortype.name)
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
        elsif ($platsur.index("browser")!=nil) then
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
        $dimension=1; $sector=1;
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
            xplotters = "  "; xplnum=@xmin+1; xplotters="  " if @xmin<0;
        puts "Measuring plot size... Calculating Areas..."
        while(xplnum<=@xmax+2)
            curd,curd2="  "; curd=" ".to_s if xplnum<0;
            xplotters+=curd.to_s+xplnum.to_s+curd2.to_s;
            xplnum+=1
            break if xplnum>=@xmax+2;
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
    
$plugins={
    "GG Installer"=>"GG Plugins/install.rb"
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
    $minusamt=2; $eminusamt=3;
def attack(targ)
    error("target needs to be Symbol (:target)",ArgumentError) if targ.class!= Symbol;
    $battle['target']=targ
    targets=[:knee,:hands,:lhand,:rhand,:rleg,:lleg,:eyes,:mouth,:nose,:face,:head,:lap,:thighs,:stomach,:tummy,:neck]
    if targ==$battle['opponent']['weakpoint'] then
        $battle['opponent']['lives']-=$eminusamt;
    else
        $battle['opponent']['lives']-=$minusamt;
    end
    puts "Attacked the #{$battle['opponent']['name'].to_s}'s #{targ.to_s}!"
        
end
$dead=false;
def checkdeads
    if ($lives<=0) then; $dead=true; end;
end
def evoke(magic)
    magic=magic.to_s
    if (magic.index('whitemagic')!=nil) then
        $lives+=2;
    end
    if (magic.index('greenmagic_levitate')!=nil) then
        $altitude+=5;
    end
        puts "Magic evoked."
end
def webhost!
    puts "Your host Internet Protocol Address (IP) is: \n"+$ip;
end
    $weapon_choices=[:stone_sword, :rust_sword, :iron_sword, :blackmagic_sword, :whitemagic_sword, :yinyang_sword, :diamond_sword, :stone_ax, :rust_ax, :iron_ax, :diamond_ax, :fists, :firebreath, :hyperbeam, :powerbeam];
$weapon= :fists;
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
$tutorialcomp=false;


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
def tutorial
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
            p1over=false; return "Are you sure you typed walk(1,0) exactly? I don't think so. Remember to type EXACTLY what is shown. Type tutorial to retry the tutorial."; 
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
        p4over=true if command.index('credits?')!=nil;
        puts "Are you sure you typed 'credits?' exactly? Don't type for an other system variable like log?, as we wanted you to type for the credits variable. Type tutorial to retry." if p4over===false;
    end
    if (p4over===true) then
        puts "Okay, one last, very critical thing before something awesome and fun: $loc and $grid. These 2 commands are very powerful. They are called 'codejectors' or CJ's. The $loc command outputs a CJ classified as a Point, which is an area on the GameGrid. It represents your current location. The $grid command outputs a CJ, classified as a Grid. It is the actual GameGrid, with tens to thousands of associated points. When you command for these CJs, they will show you some code. You may not understand it, but that doesn't matter. You have to utilitize the 'methods' on these CodeJectors. Methods are ways to uncover info, or do a function. The $loc.this function shows you info about where you're at. $loc.x and $loc.y show you your coordinates. If you command this: $grid[x,y] and replace x and y with valid coordinate numbers, it will  show you a CJ for the point on that coordinated area.\n\nWhy don't you type $grid.points, just to see the code (code means, basically your computer's native language) on that CJ that stores the grid's points?"
        command=gets
        if (command.index("$grid.points")!=nil) then
            puts $grid.points
            puts "Great job! See all that code? It may seem weird to you, but trust me, once you learn a code language like Ruby or JavaScript, you'll see how simple and effective it is. Let's move on to new stuff, man!"
            else; return "I don't think you commanded for $grid.points. Try again.";         
        end
        
        
        puts "\n\nYou're a fast learner! But the most important thing we need to learn: battles. Let's begin our battle tutorial. \n\n Pretend you're walking on the street, and you see a bandit with his weak weapon: a stick. It's time for you to learn how to battle. Your weapon currently: kitchen knife. Okay, before you get noticed, jab him on the knee. Type 'attack(:knee)'."
        command=gets; p5_1over=false;
        if(command.index("attack")!=nil&&command.index(":")!=nil) then
           p5_1over=true
        else
            return "Oh no! We couldn't parse (understand) your command. The bandit noticed you and hit you in the eye. You immediately fainted. Please try the tutorial again."
        end
    end
    
    if (p5_1over===true) then
        puts "Good job! He immediately fell down, and started examining his wound on his #{$battle[:target]}. Oh, no! He noticed you! He drops his weapon in awe. Quick! Get his weapon! Type pickup(:weapon) to grab his beating stick."
        command=gets; p5_2over=false; 
        if (command.index("pickup")!=nil&&command.index(":weapon")!=nil) then
            p5_2over=true;
        else; return "Oh no! We couldn't parse (understand) your command. The bandit caught you and hit you in the eye. You immediately fainted. Please try the tutorial again."
        end
    end
    if (p5_2over===true) then
        $tutorialon=false; $tutorialcomp=true;
        log("Tutorial completed.")
        puts "Awesome! Now your neighbors have called the police. The job has been done. You know how to walk, jump, attack, get variables, and much more. Your first mission is done. Now get ready for some more awesomeness. The SpyForce have hired you! You now go by the secretive name, Agent X, and you must keep your real identity, "+scrape_username+", away from the public. Congratulations! You have successfully completed the tutorial.\n\n NOTICE: Hey "+scrape_username+", I haven't seen you in a while, so I might not remember your name right. Why don't you type your name or email, so I can recognize you right? (if you don't want to, type quit)"
        nm=gets.chomp
        return "Good job on finishing that tutorial!" if nm.index("quit")!=nil;
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
        
$loadedplugin=''        
        
        
#Play: start playing GameGrid!
def play
    #Check if tutorial is completed.
    if ($tutorialcomp!=true) then; return "Please complete the tutorial by typing tutorial and hitting enter, before you start the game. To start the tutorial, type 'tutorial' and hit the enter/return key."; end;
    
    #Sector -1 is a Developer testing sector.
    if ($sector==-1)
        puts "Welcome, to the Developer Plugin Test sector, referred to as Sector -1. Use this sector to access loaded plugins, easily. DO NOT use Sector 0, for any uses, unless you are an administrator of GameGrid. Thank you. The loaded plugin is processing... When done loading, your most recently installed plugin will activate...\n\n"
        eval($loadedplugin)
    end
        #==== D1, S1====#
    if ($sector==1) then
        puts "Hello, and welcome to GameGrid! We see you've completed the tutorial nicely, so we're letting you into Dimension I (or D1). The first dimension, is a new world to you. It's exactly where you'll begin your search for The Royal Eyes. They are your token to achieving a huge advantage, and unlocking Dimension II (D2). There are a few new variables you should master: $dimension, shows your current dimension,, $sector, shows your current sector. You don't really need a tutorial to practice those, so we're movin' on!\n\n"
        puts "It looks like you're feeling thirsty. You see a water fountain, next to a stone wall. There's a guard, protecting that fountain. He's on Zuki (the villain)'s army. It's best to battle him, and go to that fountain. Let's do this. Come on, "+ENV['USER']+"!"
        $loc.x=1; $loc.y=1;
        #Battle Setup
        $battle = {
            'target'=>:knee,
            'opponent'=>{'name'=>:guard, 
                'lives'=>4,
                'energy'=>75,
                'active'=>true,
                'weapon'=>:stone_sword,
                'weakpoint'=>:face},
            'type'=>:close_combat
        }
        puts "\n\n Okay, we need to slowly approach him from the sides. When you do an attack while you weren't noticed, it has slightly greater effects. So make sure to walk, only up to 2 steps at a time, or else, he'll hear us. The guard stands at 4,2. Let's get him! But go slow. Remember how to walk? Start walking!"
        while($loc.x!=4||$loc.y!=2)
            command=gets; eval(command); 
            break if $loc.x==4&&$loc.y==2
        end
        if ($loc.x==4&&$loc.y==2)
            puts "Good! Now let's punch him with our fists. He has 4 lives, 75 energy, and a stone sword. Just telling you, his weak point is his face. Remember how to use the attack command? Go for it!"
            command=gets; eval command
            if $battle['opponent']['lives']<3 then
                puts "He lost "+(4-$battle['opponent']['lives']).to_s+" lives! He immediately ell to the ground, bruised by your punch. But he's still undefeated! We better get him back, again. Start the attack!"
                command=gets; eval command;
                if $battle['opponent']['lives']<1 then
                    puts "Awesome! He's defeated, and we can stock up on water! Right now, you have 80 energy. But let's take a drink! *gulp* *gulp* You now have 100 energy. Cool! Let's move on to Sector 2."
                    $sector=2;
                    puts "Welcome to Sector 2, of the first dimension."
                end
            end
        end
    end
            #D1, S2
    if ($sector==2) then
        puts "Hello! You're currently in Sector 2, of Dimension 1. That grey, metallic factory over there pumps white magic, a special kind of magical substanced used to heal, or restore. But sadly, th factory owner sold it to the horrible  Zuki. He plans to use white magic, to make himself invincible! You better put a stop sign to this business. When you go in, there'll be 3 guards waiting to kill you. These are not normal guards. When they want to attack, they float in the air, and twist and combine into one huge, one-eyed snake with all their power combined! The only way to defeat them, is to use a better weapon. Here, is a stone ax. It's not very powerful, but it's certainly better than your fists! Now go beat the juice outta them!"
        $weapon= :stone_ax;
        puts "type 'enter' to enter the factory"; ifenteredfac=false;
        entered=gets; if (entered.index("e")!=nil) then; ifenteredfac=true; end;
        if (ifenteredfac==true) then
            puts "*you enter through the door*\n\n You see 3 men.\n\nBOOOM!!! The 3 men fly up in the air, and merge into a one-eyed, huge snake. It's killing time. Remember, think logically. You're battling a gigantic snake with one eye. What would be it's weakpoint? Engage the attack! Use the attack command. Remember, think logically. The snake can regenerate itself. But if you think logically, and hit it's weakpoint, it'll immediately collapse. Go!"
            command=gets;
                notquite= "Good hit! But the snake immediately regenerated it's health! Remember, think logically. What would be a huge, merged, one-eyed snake's weakpoint? Keep attacking!"
            while(command.index(":eye")==nil) 
                puts "Good hit! But the snake immediately regenerated it's health! Remember, think logically. What would be a huge, merged, one-eyed snake's weakpoint? Keep attacking!"
                command=gets
                if (command.index(":eye")!=nil) then; break; end;
            end
                
            if (command.index(":eye")!=nil) then
                puts "Awesome! Good job, thinking logically. The snake's eye gradually closed, and the snake burnt to ashes. Now, we need to stop this factory. Let's attack that circuit board, over there. Type attack(:circuitboard) to do so!"; facdestroyedd=false;
                command=gets; if command.index(":circuitboard")!=nil then; facdestroyedd=true; else; puts "Oh no! You mistyped! The computer broke down. Type play to restart Sector 2, and use the answers you know to get back, and oh, remember to type correctly! :D"; end;
                if (facdestroyedd==true) then
                    puts "Way to go! The circuits exploded, and the factory closed down. I put some white magic in your pockets, just in case. We can now get to Sector 3. Good job!"
                    $sector=3;
                end
            end
        end
    end
                #D1, S3
    if ($sector==3) then
        $weapon=:stone_ax;
        puts "Hello, and welcome to Sector 3. You are currently in a vast desert, it seems. But see that boulder over there? Behind that huge rock, is a 10-foot tall soldier. Many of our soldiers couldn't defeat such a large man. He's defense is very easy to overtake, but his attacks are powerful blows. First, let's get a better weapon. Look, over there! Someone seems to have forgotten their iron sword! Pick it up, using pickup(:iron_sword) command!"
        command=gets; $weapon=:iron_sword if (command.index("pickup")!=nil&&command.index(":iron_sword")!=nil);
        if ($weapon==:iron_sword) then
            puts "Iron swords are much more powerful than stone axes. But more than attack power, we need defense. What about we use the white magic we stored? Here's a new command for you, called evoke. The evoke command activates the power of magic. For white magic, we call it like this: evoke(:whitemagic). This will help you in battle, when you only have 1 or 1/2 lives left. Let's take him by surprise at first. He's probably asleep right now. Go get him! Oh, and his weakpoint is his neck, as he fractured it very bad. But he's so tall, we can't even reach his neck! Wait, I have an idea! I'll teach you another evoke command: evoke(:greenmagic_levitate). It's long, but worth it. It'll raise your altitude! Use it now, to prepare:"; $altitude=10;
        command=gets; 
            $altitude=15 if command.index("greenmagic_levitate")!=nil;
            if ($altitude>14) then
                $loc.x=6; $loc.y=2
 puts "You're floating at altitude "+$altitude.to_s+"! Good, now let's get him well. He has 7 lives, and an iron sword, too. But don't worry, we'll defeat him. Use the evoke command on white magic to heal yourself. Let's do this! Let's creep up on him while he naps. Walk to 3,3, cause that's where he is. You are currently standing at 6,2. You need to walk to 3,3. Go! "
                while($loc.x!=3||$loc.y!=3)
                    command=gets; eval(command); 
                    break if $loc.x==3&&$loc.y==3
                end
                if ($loc.x==3&&$loc.y==3) then
                    #Battle Setup
                     $battle = {
                            'target'=>:knee,
                            'opponent'=>{'name'=>:soldier, 
                                'lives'=>7,
                                'energy'=>75,
                                'active'=>false,
                                'weapon'=>:iron_sword,
                                'weakpoint'=>:neck},
                            'type'=>:close_combat
                        }
                    puts "Okay, good. So there he is. His sleeping pouch is like 15 feet long, so it can fit him! OK, first, let's sneak up a small attack on him. Remember, his weakpoint is his fractured neck. Go!"; $lives==5;
                    command=gets;
                    eval(command);
                    if $battle['opponent']['lives']<7 then
                        puts "YAWWWN! The giant soldier is waking up! Quick, get another hit on him!"
                        command=gets;
                        eval(command);
                        if $battle['opponent']['lives']<5 then
                            $lives-=3;
                            puts "URRRGH! The giant soldier is ready to attack! WHAP! Oh no, he whapped you in the face! His hits are VERY hard. You just lost 3 lives, and only have 2!!! Okay, you can either attack him back, or heal yourself magically, by evoking white magic. Go!"; #$lives-=3;
                            command=gets; eval(command)
                            
                            puts "Good! The opponent still stands strong. He gets his fists ready for another whapping! Quick, do something! Either, you can heal yourself, with white magic, or attack him! What do you choose? Do it!";         command=gets; eval(command)
                            if ($battle["opponent"]["lives"]<=0) then
                                puts "Boom! The soldier slid to the ground, as his eyes closed, and his movement decreased. We did it! Let's move up to Sector 4."; $sector=4; return "Let's have some fun, cause we just entered the 4th Sector! Type play to start the 4th Sector!"; end
                            puts "Good job! You have #{$lives} lives, and the opponent has #{$battle['opponent']['lives']} lives. But the battle hasn't finished yet! Let's go and show him what we can do! Cause we are—WHAP! HE whapped you AGAIN!"; $lives-=3;
                            checkdeads();
                            return "OWW! Oh, that's not good. You died! Those hits were hard. Wait just a sec, I'll fix up your bruises. WHOOSH! There you go, all nice and healthy! Now go get that fiant dude again! Type play to retry that battle!                     "  if dead==true;
                            puts "Okay, even though you only have #{lives} lives, I know we can still overtake him. You can either heal or attack, but I reccommend attacking, as your opponent has only a few lives, left. Go!"
                            command=gets; eval(command)
                            if ($battle["opponent"]["lives"]<=0) then; $sector=4;
                                puts "Boom! The soldier slid to the ground, as his eyes closed, and his movement decreased. We did it! Let's move up to Sector 4."; return "Let's have some fun, cause we just entered the 4th Sector! Type play to advance to Sector 4!"
                            else
                                puts "Oh no! I see that the opponent is preparing a SUPERBLAST! We should have attacked those times, instead of healing! BOOOOM!!!!!!!"; $lives==0; checkdeads();
                                return "OWW! Oh, that's not good. You died! Those hits were hard. Wait just a sec, I'll fix up your bruises. WHOOSH! There you go, all nice and healthy! Now go get that giant dude again! Type play to retry that battle! Oh, and try not to keep attacking or keep healing all the time!"  if $dead==true;
                                
                            end
                        end
                    end
                end
            end
        
        end
        
    end
    #D1, S4
    if ($sector==4) then
        puts "Let's have some fun, cause we just entered the 4th Sector!"
        
    end
end
beginning_survey() unless $begsurvdone===true;

#PLUGINS
$useplugindata=true; #$ccellar='';
begin
    if ($useplugindata) then
            $plgvaldb=''; 
            File.open("plgvaldb.rb", "r").each_line do |line|
                $plgvaldb+=line
            end
            #rescue SyntaxError
            
        $plgvaldb=eval($plgvaldb)
        module Plugin
            def self.new(rubycode, name="Plugin.new")
                $plgvaldb[name.to_s]=rubycode.to_s
                hasher={name.to_s=>rubycode.to_s}
                puts "To install only locally, use Plugin.install(#{name}).\n To push to GameGrid servers, so the public can install your plugin, send an email with your Plugin name and Plugin code to tt2d [at] icloud [dot] com. \nTo see the output of your plugin, use self.load with an argument equal to this hash: \n"
                return hasher
            end
            def self.load(hasher)
                error("Argument must be a hash, formulated by Plugin.load(code,name) function",ArgumentError) if hasher.class!=Hash;
                eval(hasher.values[0])
            end
            def self.loadAll(*pk)
                loadnum=0
                while (loadnum<pk.length)
                    self.load(pk[loadnum])
                    loadnum+=1;
                end
            end
            def self.install(id)
                puts "Tracking plugin ID..."
                id=id.to_s
                raker=$plgvaldb[id]
                $loadedplugin=raker.to_s
                puts "Your plugin, #{id} has been loaded. To run this plugin, you can either type $sector=-1; play if you have completed the tutorial, or you can type Plugin.run() to run the plugin, even if the tutorial was not done. Thank you."
            end
            def self.run()
                raise "No plugin loaded yet", LoadError if ($loadedplugin=='');
                eval($loadedplugin);
            end
        #eval($ccellar)
        end
    end
rescue
$useplugindata=false; log("Plugin content disable due to error rescuer"); retry
end
    