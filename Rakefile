$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "twkb/version"
 
task :build do
  system "gem build twkb.gemspec"
end
 
task :release => :build do
  system "gem push twkb-#{TWKB::VERSION}.gem"
end
