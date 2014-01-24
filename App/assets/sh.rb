version="0.9.5.2.2"
code='
function edit(){
echo "Please enter a valid password: "
    VALIDPWD="carnatic"
    read -s PASSWORD
    if [ "$PASSWORD" == VALIDPWD ]; then
    open lib/GameGrid.rb;
    fi
}
function usage(){
usage=$\'Welcome to GameGrid! Here are possible commands:\n-g/--pull/--get/--update  means update or pull the latest code.\n-e/--edit means try editing the game code (requires password)\n-h/--help brings this usage page up\n -v/--version prints the version.\'
echo "$usage"
}
version="'+version+'";
while [ "$1" != "" ]; do
    case $1 in
        -g | --pull | --get | --update)           shift
                                gem install GameGrid
                                ;;
        -e | --edit )           edit
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        -v | --version )        echo $"\nVersion: $version, to update to the latest, type gamegrid --update\n";;
        
        * )                     echo $"\nCommand unavailable. Valid commands:\n\n"
                                usage
                                exit 1
    esac
    shift
done

if [ "$1" == "" ]; then
echo $"Type this: require \'GameGrid\' to begin playing.\n\n"
irb
fi'

File.open("/usr/local/bin/gamegrid", 'w') {|f| f.write(code) };

File.open("/usr/bin/gamegrid", 'w') {|f| f.write(code) };