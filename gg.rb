module GG
    
    
end




Shoes.app do 
    $bg=background( gradient(gold, aqua, purple) )
    $title=para "Welcome to GameGrid".style  font: 'Helvetica Neue Ultralight 34px', color: blue
    motion do |left,top|
        c1=rgb(top,left,rand(245)); c2=rgb(left,top,rand(245));
        $bg=background( gradient(c1, c2, gold) );
    end
end