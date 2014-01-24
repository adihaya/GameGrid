
Shoes.app(width: 1400, height: 860, resizable: true) do 
background "#fff9f9"; @origcenter=(width/3.333/1).round; @centerl=300; 

        @logo=image("https://www.google.com/images/srpr/logo11w.png");
        mnum=3; emnum=28; tnum=1.8
        @logo.style align: 'center', :center => true, left: (width/mnum/1).round, top: (height/mnum/1).round 
        @txt=flow do
        @edit=edit_line; @edit.style font:'Helvetica Neue Ultralight 20px', width: 1265, align: 'center', :center => true, left: 3, top: (height/tnum/1).round 
        @editideas="IDEAS:  Who is Isaac Newton?                                 What are parabolas?                                 How do I cook a snow cone?                                 Is Pluto really a planet?                                 Why is the sky blue?"
        @ideas=para @editideas; @ideas.style font:'Helvetica Neue Ultralight 15px', left:5, top:530
        @btn=button "Search", font:'Helvetica Neue Ultralight 20px'; @btn.focus(); @btn.style left:1300, top:480
        @btn.click do |o|
            g="http://www.google.com/search?visitor=googleappbytlgq="
            q=@edit.text.to_s
            url=g+q+"#q="+q
            debug("URL:"+url)
            visit(url) and debug("devpnil") if q.index("devp:")==nil;
            if (q.index("devp:")!=nil) then
                cmd=q.chomp!("devp:")
                debug("cmd: "+cmd)
                @devp=para (eval(cmd)), font:'Courier New 20px', left:5, top:530 
            end
        end
        hover do |obj|
            @edit.text="" if obj==@edit;
        end
        $sall=false;
        end
    keypress do |k|
        case k
            when :alt_c
                self.clipboard=@edit.text.to_s
            when :alt_v
                @edit.text=@edit.text.to_s+self.clipboard
            when :alt_w
                confirm("Here's what you were searching for: "+@edit.text.to_s) if (@edit.text.to_s.length>1);
                
            when :alt_q
                confirm("Here's what you were searching for: "+@edit.text.to_s) if (@edit.text.to_s.length>1);
            when :alt_a
                $sall=true;
            when :backspace
                @edit.text=@edit.text.to_s.slice(-1) if $sall!=true;
                @edit.text="" if $sall==true;
        end
    end
end