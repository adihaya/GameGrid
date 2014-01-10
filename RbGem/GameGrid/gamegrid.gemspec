#% cat hola.gemspec
Gem::Specification.new do |s|
  s.name        = 'GameGrid'
  s.version     = '0.9.5'
  s.date        = '2014-01-09'
  s.summary     = "Hola!"
  s.description = "An in-command-line adventure game controlled by commands like pickup(:sword) and attack()"
  s.authors     = ["ThinkLikeGeek"]
  s.email       = 'tt2d@icloud.com'
  s.files       = ["lib/main.rb","lib/install.rb","lib/GameGrid.rb","lib/plgvaldb.rb"]
  s.homepage    =
    'http://adihaya.github.io/GameGrid'
  s.license       = 'MIT'
end