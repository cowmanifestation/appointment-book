require "rubygems"
require "highline/import"

number = ask("What number?    ", Integer) {|q| q.in = 0..13}

say "#{number}"