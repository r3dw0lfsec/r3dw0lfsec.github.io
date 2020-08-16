# -*- encoding: utf-8 -*-
# stub: jekyll-theme-hydejack 9.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-theme-hydejack".freeze
  s.version = "9.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Florian Klampfer".freeze]
  s.date = "2020-07-03"
  s.email = ["mail@qwtel.com".freeze]
  s.homepage = "https://hydejack.com/".freeze
  s.licenses = ["GPL-3.0".freeze]
  s.required_ruby_version = Gem::Requirement.new("~> 2.6".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "\"Best Jekyll Theme by a Mile\"".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<jekyll>.freeze, [">= 3.8"])
    s.add_runtime_dependency(%q<jekyll-include-cache>.freeze, ["~> 0.2"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<jekyll>.freeze, [">= 3.8"])
    s.add_dependency(%q<jekyll-include-cache>.freeze, ["~> 0.2"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.12"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
