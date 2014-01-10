puts "Hi and welcome to GameGrid, the internal in-console game. While installation occurs, you will see some log text. You do not have to read/understand that."
homedir=ENV["HOME"]; pwd=ENV["PWD"]; puts "\n\n Directories set..."
$ggrb=""

puts "O: GameGrid.rb"
File.open("lib.bundle/GameGrid.rb", "r").each_line do |line|
  $ggrb+=line
end
#puts $ggrb
$dlht=""
puts "O: DL Beta html"
File.open("lib.bundle/GameGridUpdater.html", "r").each_line do |line|
  $dlht+=line
end
$bcss=""
puts "O: boilerplate.css"
File.open("lib.bundle/boiler.css", "r").each_line do |line|
  $bcss+=line
end
$pcss=""
puts "O: page1.css"
File.open("lib.bundle/page.css", "r").each_line do |line|
  $pcss+=line
end
$lgif=""
puts "O: loader.gif"
File.open("lib.bundle/loadergif.txt", "r").each_line do |line|
  $lgif+=line
end
puts "Files gripped. "


require 'fileutils'; puts "Loaded FileUtilities. "

File.open("/Applications/GameGrid.rb", 'a+') {|f| f.write($ggrb) }; puts "Files pushed to /Applications/GameGrid.rb";
File.open("/Applications/loader.gif", 'a+') {|f| f.write($lgif) }; puts "Images pushed to /Applications/GameGrid.rb";
File.open("/Applications/GameGrid Updater.html", 'a+') {|f| f.write($dlht) }; puts "Updates pushed to /Applications/GameGrid Updater.html";

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
