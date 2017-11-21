# -*- encoding: utf-8 -*-
# stub: slack-ruby-bot 0.10.5 ruby lib

Gem::Specification.new do |s|
  s.name = "slack-ruby-bot".freeze
  s.version = "0.10.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Doubrovkine".freeze]
  s.date = "2017-10-16"
  s.email = "dblock@dblock.org".freeze
  s.homepage = "https://github.com/slack-ruby/slack-ruby-bot".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "The easiest way to write a Slack bot in Ruby.".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashie>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<slack-ruby-client>.freeze, [">= 0.6.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.38.0"])
    else
      s.add_dependency(%q<hashie>.freeze, [">= 0"])
      s.add_dependency(%q<slack-ruby-client>.freeze, [">= 0.6.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.38.0"])
    end
  else
    s.add_dependency(%q<hashie>.freeze, [">= 0"])
    s.add_dependency(%q<slack-ruby-client>.freeze, [">= 0.6.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.38.0"])
  end
end
