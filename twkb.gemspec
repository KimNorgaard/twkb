# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twkb/version"

Gem::Specification.new do |s|
  s.name        = 'twkb'
  s.version     = TWKB::VERSION
  s.date        = '2013-05-01'
  s.summary     = "TaskWarrior Kanban"
  s.description = "A command line utility based on task warrior to create kanban boards."
  s.authors     = ["Kim Nørgaard"]
  s.email       = 'jasen@jasen.dk'
  s.files       = ["lib/twkb.rb"]
  s.homepage    = ""

  s.add_runtime_dependency 'terminal-table', '~>1.4.5'
  s.add_runtime_dependency 'parseconfig', '~>1.0.2'
  s.add_runtime_dependency 'rainbow', '~>1.1.4'

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
