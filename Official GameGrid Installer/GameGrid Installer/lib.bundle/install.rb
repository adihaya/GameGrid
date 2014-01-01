puts "Hi and welcome to GameGrid, the internal in-console game. While installation occurs, you will see some log text. You do not have to read/understand that."
homedir=ENV["HOME"]; pwd=ENV["PWD"]; puts "\n\n Directories set..."
$ggrb=""

puts "O: GameGrid.rb"
File.open("GameGrid.rb", "r").each_line do |line|
  $ggrb+=line
end
#puts $ggrb
$dlht=""
puts "O: DL Beta html"
File.open("Download Latest Beta Version.html", "r").each_line do |line|
  $dlht+=line
end
$bcss=""
puts "O: boilerplate.css"
File.open("boiler.css", "r").each_line do |line|
  $bcss+=line
end
$pcss=""
puts "O: page1.css"
File.open("page.css", "r").each_line do |line|
  $pcss+=line
end
$lgif=""
puts "O: loader.gif"
File.open("loadergif.txt", "r").each_line do |line|
  $lgif+=line
end
puts "Files gripped. "
$gripp=true; $ggin=""
begin
    if ($gripp==true) then
            File.open("GG Plugins/install.rb","r").each_line do |l|; $ggin+=l; end;
            puts "Gripping plug ins..."
    end
rescue
    $gripp=false; puts "Rescued plug-in installations..."; retry; 
end
    

require 'fileutils'; puts "Loaded FileUtilities. "

    
$gpdirname = File.dirname("/Applications/GG Plugins"); puts "Plugin folder creation initiated...."
unless File.directory?($gpdirname)
  FileUtils.mkdir_p($gpdirname); puts "Plugin folder created...";
end
    puts "Plugin folder succeeded..."
#File.open("/Applications/GG Plugins/install.rb", 'a+') {|f| f.write($ggin); puts 'wrlin'}; puts "Tools pushed to /Applications/GameGrid.rb";
File.open("/Applications/GameGrid.rb", 'a+') {|f| f.write($ggrb) }; puts "Files pushed to /Applications/GameGrid.rb";
File.open("/Applications/loader.gif", 'a+') {|f| f.write($lgif) }; puts "Images pushed to /Applications/GameGrid.rb";
File.open("/Applications/GameGrid Updater.html", 'a+') {|f| f.write($dlht) }; puts "Updates pushed to /Applications/GameGrid Updater.html";
    
puts "Plugin update started"; $gripl=true;
    begin; if ($gripl) then
FileUtils.copy_entry("GG Plugins", "/Applications/GG Plugins",false,false,true); puts "Updating plugins......"
FileUtils.copy_entry("plgvaldb.rb", "/Applications/plgvaldb.rb",false,false,true); puts "Updating plugins......"
    end;
    rescue
        $gripl=false; retry; end;

$gdirname = File.dirname("/Applications/Welcome - assets/assets"); puts "Assets folder creation initiated...."
#___ Here so far
unless File.directory?($gdirname)
  FileUtils.mkdir_p($gdirname); puts "Assets folder created...";
end
File.open("/Applications/__boilerplate.css", 'a+') {|f| f.write($bcss) }; puts "Styles pushed to /Applications/GameGrid Updater.html";
File.open("/Applications/__page1.css", 'a+') {|f| f.write($pcss) }; puts "Drivers pushed to /Applications/GameGrid Updater.html";

puts "Assets updated.."

puts "\n\n Installing files...";
 
puts "Files successfully installed in /Applications folder"
%x( cd ); %x(ls /Applications/)
%x( echo "Look for GameGrid.rb above. If it is there, installation was successful. To play, open that file, copy all content, go to Terminal/CommandPrompt, type irb and hit enter, then paste all that you've copied, wait for it to load, then hit enter." )
puts "Locate GameGrid.rb in /Applications. To play, open that file, copy all content, go to Terminal/CommandPrompt, type irb and hit enter, then paste all that you've copied, wait for it to load, then hit enter."
    
