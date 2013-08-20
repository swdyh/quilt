require 'rubygems'
require 'rake'
#require 'rake/clean'
require 'rake/testtask'
#require 'rake/packagetask'
#require 'rubygems/package_task'
#require 'rake/rdoctask'
#require 'rake/contrib/rubyforgepublisher'
#require 'rake/contrib/sshpublisher'
require 'bundler/gem_tasks'
require 'fileutils'
require 'date'
include FileUtils

NAME              = "quilt"
AUTHOR            = "swdyh"
EMAIL             = "youhei@gmail.com"
HOMEPATH          = "https://github.com/swdyh/quilt"
SUMMARY           = "A Ruby library for generating identicon."
DESCRIPTION       = SUMMARY + "\n" + HOMEPATH
# RUBYFORGE_PROJECT = "quilt"
BIN_FILES         = %w(  )
VERS              = "0.0.7"

REV = File.read(".svn/entries")[/committed-rev="(d+)"/, 1] rescue nil
#CLEAN.include ['**/.*.sw?', '*.gem', '.config']
RDOC_OPTS = [
	'--title', "#{NAME} documentation",
	"--charset", "utf-8",
	"--opname", "index.html",
	"--line-numbers",
	"--main", "README.rdoc",
	"--inline-source",
]

task :default => [:test]
task :package => [:clean]

Rake::TestTask.new("test") do |t|
	t.libs   << "test"
	t.pattern = "test/**/*_test.rb"
	t.verbose = true
end

spec = Gem::Specification.new do |s|
	s.name              = NAME
	s.version           = VERS
	s.platform          = Gem::Platform::RUBY
	s.has_rdoc          = true
	s.extra_rdoc_files  = ["README.rdoc", "ChangeLog", "MIT-LICENSE"]
	s.rdoc_options     += RDOC_OPTS + ['--exclude', '^(examples|extras)/']
	s.summary           = DESCRIPTION
	s.description       = DESCRIPTION
	s.author            = AUTHOR
	s.email             = EMAIL
	s.homepage          = HOMEPATH
	s.executables       = BIN_FILES
#	s.rubyforge_project = RUBYFORGE_PROJECT
	s.bindir            = "bin"
	s.require_path      = "lib"
#	s.autorequire       = ""
	s.test_files        = Dir["test/test_*.rb"]
	s.license = "MIT"
	#s.add_dependency('activesupport', '>=1.3.1')
	#s.required_ruby_version = '>= 1.8.2'
	s.add_development_dependency "bundler"
	s.add_development_dependency "rmagick"
	s.add_development_dependency "ruby-gd"

	s.files = %w(README.rdoc ChangeLog Rakefile) +
		Dir.glob("{bin,doc,test,lib,templates,generator,extras,website,script}/**/*") + 
		Dir.glob("ext/**/*.{h,c,rb}") +
		Dir.glob("examples/**/*.rb") +
		Dir.glob("tools/*.rb")

	s.extensions = FileList["ext/**/extconf.rb"].to_a
end

# Rake::GemPackageTask.new(spec) do |p|
# 	p.need_tar = true
# 	p.gem_spec = spec
# end

# task :install do
# 	name = "#{NAME}-#{VERS}.gem"
# 	sh %{rake package}
# 	sh %{sudo gem install pkg/#{name}}
# end

# task :uninstall => [:clean] do
# 	sh %{sudo gem uninstall #{NAME}}
# end

# Rake::RDocTask.new do |rdoc|
# 	rdoc.rdoc_dir = 'html'
# 	rdoc.options += RDOC_OPTS
# 	rdoc.template = "resh"
# 	#rdoc.template = "#{ENV['template']}.rb" if ENV['template']
# 	if ENV['DOC_FILES']
# 		rdoc.rdoc_files.include(ENV['DOC_FILES'].split(/,\s*/))
# 	else
# 		rdoc.rdoc_files.include('README.rdoc', 'ChangeLog')
# 		rdoc.rdoc_files.include('lib/**/*.rb')
# 		rdoc.rdoc_files.include('ext/**/*.c')
# 	end
# end

# desc "Publish to RubyForge"
# task :rubyforge => [:rdoc, :package] do
# 	require 'rubyforge'
# 	Rake::RubyForgePublisher.new(RUBYFORGE_PROJECT, 'swdyh').upload
# end

# desc 'Package and upload the release to rubyforge.'
# task :release => [:clean, :package] do |t|
# 	v = ENV["VERSION"] or abort "Must supply VERSION=x.y.z"
# 	abort "Versions don't match #{v} vs #{VERS}" unless v == VERS
# 	pkg = "pkg/#{NAME}-#{VERS}"

# 	rf = RubyForge.new
# 	puts "Logging in"
# 	rf.login

# 	c = rf.userconfig
# #	c["release_notes"] = description if description
# #	c["release_changes"] = changes if changes
# 	c["preformatted"] = true

# 	files = [
# 		"#{pkg}.tgz",
# 		"#{pkg}.gem"
# 	].compact

# 	puts "Releasing #{NAME} v. #{VERS}"
# 	rf.add_release RUBYFORGE_PROJECT, NAME, VERS, *files
# end

desc 'Show information about the gem.'
task :debug_gemspec do
  puts spec.to_ruby
end

desc 'Update information about the gem.'
task :update_gemspec do
  open("#{NAME}.gemspec", 'w') { |f| f.puts spec.to_ruby }
end

task :update => [:update_gemspec, :build]
