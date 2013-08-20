# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "quilt"
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["swdyh"]
  s.date = "2013-08-20"
  s.description = "a library for generating identicon."
  s.email = "youhei@gmail.com"
  s.extra_rdoc_files = ["README.rdoc", "ChangeLog", "MIT-LICENSE"]
  s.files = ["README.rdoc", "ChangeLog", "Rakefile", "test/quilt_test.rb", "test/test_helper.rb", "lib/quilt.rb", "examples/gen.rb", "MIT-LICENSE"]
  s.homepage = "https://github.com/swdyh/quilt"
  s.rdoc_options = ["--title", "quilt documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "quilt"
  s.rubygems_version = "2.0.7"
  s.summary = "a library for generating identicon."
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rmagick>, [">= 0"])
      s.add_development_dependency(%q<ruby-gd>, [">= 0"])
    else
      s.add_dependency(%q<rmagick>, [">= 0"])
      s.add_dependency(%q<ruby-gd>, [">= 0"])
    end
  else
    s.add_dependency(%q<rmagick>, [">= 0"])
    s.add_dependency(%q<ruby-gd>, [">= 0"])
  end
end
