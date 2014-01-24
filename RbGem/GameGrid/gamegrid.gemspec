#% cat hola.gemspec
Gem::Specification.new do |s|
  s.name        = 'GameGrid'
  s.version     = '0.9.5.2.8'
  s.date        = '2014-01-10'
  s.summary     = "An in-command-line adventure game, filled with attacking, crafting, etc"
  s.required_ruby_version = '>= 1.8.7'
  s.post_install_message = "Thank you for installing GameGrid! We hope you enjoy our self-explanatory adventure game, built on commands. To start the game, type this: irb;  , and then hit enter, then type this: require 'GameGrid'; , and then hit enter, and the game's starting 3-question survey has begun. After the survey, type tutorial and hit enter to begin the tutorial. Thanks!"
  s.requirements << 'Ruby (on macs this is pre-installed) version 1.8.7 or later'
  s.requirements << 'A computer with an Intel processor (not required but will help)'
  s.description = "An in-command-line adventure game controlled by commands like pickup(:sword) and attack()"
  s.authors     = ["ThinkLikeGeek"]
  s.email       = 'tt2d@icloud.com'
  s.files       = ["lib/main.rb","lib/install.rb","lib/GameGrid.rb","lib/plgvaldb.rb","lib/sh.rb"]
  s.executables << "sh.rb"
  s.executables << "gamegrid.rb"
 # s.require_paths=["lib"]
  s.homepage    =
    'http://adihaya.github.io/GameGrid'
  s.license       = 'MIT'
end
