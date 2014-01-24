require 'irb/ruby-lex'
require 'stringio'

class MimickIRB < RubyLex
  attr_accessor :started

  class Continue < StandardError; end
  class Empty < StandardError; end

  def initialize
    super
    set_input(StringIO.new)
  end

  def run(str)
    obj = nil
    @io << str
    @io.rewind
    unless l = lex
      raise Empty if @line == ''
    else
      case l.strip
      when "reset"
        @line = ""
      when "time"
        @line = "puts %{You started \#{IRBalike.started.since} ago.}"
      else
        @line << l << "\n"
        if @ltype or @continue or @indent > 0
          raise Continue
        end
      end
    end
    unless @line.empty?
      obj = eval @line, TOPLEVEL_BINDING, "(irb)", @line_no
    end
    @line_no += @line.scan(/\n/).length
    @line = ''
    @exp_line_no = @line_no

    @indent = 0
    @indent_stack = []

    $stdout.rewind
    output = $stdout.read
    $stdout.truncate(0)
    $stdout.rewind
    [output, obj]
  rescue Object => e
    case e when Empty, Continue
    else @line = ""
    end
    raise e
  ensure
    set_input(StringIO.new)
  end

end

CURSOR = ">>"
IRBalike = MimickIRB.new
$stdout = StringIO.new

Shoes.app(width: 1000, height: 800) do
    @su=false;
def startup()
    sc="require './assets/GameGrid.rb'; play\n"
    IRBalike.run(sc);
    @su=true;
end
    
 @cmds=[]; @lcn=1; @pcn=1; @log="Log:    ";
    def lg(msg)
        @log+=msg
    end
    def gets
        resp=ask("Type your answer/command: "); 
        resp="" if resp.nil?||resp==nil;
        return resp.to_s
    end
  @str, @cmd = [CURSOR + " "], ""
  stack :width => 1.0, :height => 1.0 do
    background "./assets/background.jpg"
    stack :width => 1.0, :height => 50 do
      @head=para "GameGrid, the in-console adventure game", :stroke => blue, :font=> "Helvetica Neue 20px"
        alert('Welcome to GameGrid!!! Click OK to load the game.')
        
      #@sprog= progress width: 150;
       #@sprog.fraction = 0.5;
    end
    @scroll =
      stack :width => 1.0, :height => -50, :scroll => true do
        background "./assets/background.jpg"
        @console = para @str, :font => "Monospace 12px", :stroke => "#dfa"
        @console.cursor = -1
      end
  end
  keypress do |k|
    case k
    when "\n"
      begin
          @cmds[@pcn]=@cmd; @pcn+=1; @lcn=@pcn-1;
        out, obj = IRBalike.run(@cmd + ';')
        @str += ["#@cmd\n",
          span("#{out}=> #{obj.inspect}\n", :stroke => '#1AFF00'),
          "#{CURSOR} "]
        @cmd = ""
      rescue MimickIRB::Empty
      rescue MimickIRB::Continue
        @str += ["#@cmd\n.. "]
        @cmd = ""
      rescue Object => e
        @str += ["#@cmd\n", span("#{e.class}: #{e.message}\n", :stroke => red),
          "#{CURSOR} "]
        @cmd = ""
            
   # wnum=0
    #        while (wnum<@str.split("\n").length) 
     #           arrs=@str.split("\n")
      #          arr=arrs[wnum]
       #         ch1=(arr.split('')[0]).to_s
        #        ch2=(arr.split('')[1]).to_s
         #       chars=ch1+ch2;
          #      if (chars!="=>"&&chars!='=>') then
           #         @str=@str.center(100)
            #    end
            #end
                
      end
    when String
      @cmd += k
    when nil.to_s
        if (@su==false) then
            startup()
        end
    when :backspace
      @cmd.slice!(-1)
    when :tab
      @cmd += "     "
    when :alt_w
            alert("Bye! GameGrid will quit when you click below: ")
      quit
    when :alt_q
        alert("Bye! GameGrid will quit when you click below: ")
      quit
    when :alt_c
      self.clipboard = @cmd
    when :alt_v
      @cmd += self.clipboard
    when :alt_l
      @cmd=@log;
    when :up
        @lcn-=1 and @cmd=@cmds[@lcn+1] unless @lcn<1;
          lg "kp: up, lcn= #{@lcn}, cmd=#{cmd}, cmds=#{cmds} "
    when :down
        @lcn+=2 and @cmd=@cmds[@lcn] unless @lcn<1;
          lg "kp: down, lcn= #{@lcn}, cmd=#{cmd}, cmds=#{cmds} "
    when :esc
            alert("Bye! GameGrid will quit when you click below: ") 
        quit
    end
    @console.replace *(@str + [@cmd])
    @scroll.scroll_top = @scroll.scroll_max
  end
end
