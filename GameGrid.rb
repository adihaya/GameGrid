$lives=5; $energy=100; $altitude=10;
class Point
    attr_accessor :x, :y, :ground, :object, :gtype
    attr_reader :id
    def when(action)
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
    return myresult
    end
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
    def this
    if (@object===nil) then
        return 'at '+@x+', #'+@y+', on '+@ground+', with no objects found.'
    else
        return 'at '+@x+', #'+@y+', on '+@ground+', with a '+@object+' found on the ground.'
    end
    end
end
$loc=Point.new(1,1,'asphalt')

def walk(up,right)
    $loc.x+=up
    $loc.y+=right
    puts "Walked #{up} points up, and #{right} points to the right. Standing on #{$loc.x}, #{$loc.y}. Location: #{$loc.this}"
end
def play 
$loc.x=1; $loc.y=1; # Reset curreny loc
puts "Welcome to GameGrid, the in-console game. You are currently standing on something called a Point. You are standing "+$loc.this
puts "Points are locations on the gamegrid. You can also move around by executing commands. Why don't you try typing walk(1,0) ?"
command=gets
eval(command)
if $loc.x===2 then
    puts "Congrats! Did you see that? You moved up on the GameGrid, by 1 point. Using the walk(up,right) command lets your player abstractly walk the grid."
else
    return "Are you sure you typed walk(1,0) exactly? I don't think so. Remember to type EXACTLY what is shown. Type play to retry the tutorial."
end
end