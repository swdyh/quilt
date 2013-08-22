require 'rubygems'
require 'rake/testtask'
require 'bundler/gem_tasks'

spec = Gem::Specification.new do |s|
  s.name              = "quilt"
  s.version           = "0.0.8"
  s.platform          = Gem::Platform::RUBY
  s.has_rdoc          = false
  s.summary           = "A Ruby library for generating identicon."
  s.homepage          = "https://github.com/swdyh/quilt"
  s.description       = s.summary + "\n" + s.homepage
  s.author            = "swdyh"
  s.email             = "youhei@gmail.com"
  s.executables       = %w(  )
  s.bindir            = "bin"
  s.require_path      = "lib"
  s.test_files        = Dir["test/test_*.rb"]
  s.license           = "MIT"
  s.files             = `git ls-files`.split("\n")
  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rmagick"
  # 'Spakman/ruby-gd' in Gemfile
end

Rake::TestTask.new("test") do |t|
  t.libs   << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

desc 'Show information about the gem.'
task :debug_gemspec do
  puts spec.to_ruby
end

desc 'Update information about the gem.'
task :update_gemspec do
  open("#{spec.name}.gemspec", 'w') { |f| f.puts spec.to_ruby }
end

desc 'Update gem'
task :update => [:update_gemspec, :build]

task :default => [:test]
