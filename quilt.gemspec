Gem::Specification.new do |s|
  s.name = %q{quilt}
  s.version = "0.0.2"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["swdyh"]
  s.date = %q{2008-06-19}
  s.description = %q{a library for generating identicon.}
  s.email = %q{youhei@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "ChangeLog", "MIT-LICENSE"]
  s.files = ["README.rdoc", "ChangeLog", "Rakefile", "test/quilt_test.rb", "test/test_helper.rb", "lib/quilt.rb", "MIT-LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://quilt.rubyforge.org}
  s.rdoc_options = ["--title", "quilt documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{quilt}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{a library for generating identicon.}
  s.test_files = ["test/test_helper.rb"]
end
