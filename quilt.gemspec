# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "quilt"
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["swdyh"]
  s.date = "2013-08-22"
  s.description = "A Ruby library for generating identicon.\nhttps://github.com/swdyh/quilt"
  s.email = "youhei@gmail.com"
  s.files = [".travis.yml", "ChangeLog", "Gemfile", "MIT-LICENSE", "README.md", "Rakefile", "lib/quilt.rb", "quilt.gemspec", "test/quilt_test.rb", "test/test_helper.rb"]
  s.homepage = "https://github.com/swdyh/quilt"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.7"
  s.summary = "A Ruby library for generating identicon."
  s.test_files = ["test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rmagick>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rmagick>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rmagick>, [">= 0"])
  end
end
