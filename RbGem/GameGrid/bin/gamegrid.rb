#!/usr/bin/env ruby
if (ARGV[0].index("update")!=nil) then
    `gem install GameGrid` or %x(gem install GameGrid)
end

    puts "Loading up the game....."
require "GameGrid"; puts "100% loaded..."
play()
