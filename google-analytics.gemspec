# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{google-analytics}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dan Webb"]
  s.date = %q{2009-04-27}
  s.description = %q{Wrapper around the Google Analytics API}
  s.email = %q{dan@danwebb.net}
  s.extra_rdoc_files = ["CHANGELOG", "lib/google_analytics/account.rb", "lib/google_analytics/client.rb", "lib/google_analytics/user.rb", "lib/google_analytics.rb", "LICENSE", "README.textile"]
  s.files = ["CHANGELOG", "lib/google_analytics/account.rb", "lib/google_analytics/client.rb", "lib/google_analytics/user.rb", "lib/google_analytics.rb", "LICENSE", "Manifest", "Rakefile", "README.textile", "test/google_analytics/client_test.rb", "test/test_helper.rb", "google-analytics.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Google-analytics", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{google-analytics}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Wrapper around the Google Analytics API}
  s.test_files = ["test/google_analytics/client_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
  end
end
