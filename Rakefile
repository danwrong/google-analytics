require 'echoe'
require 'fileutils'

Echoe.new("google-analytics") do |p|
  p.author = "Dan Webb"
  p.email = 'dan@danwebb.net'
  p.summary = "Wrapper around the Google Analytics API"
  p.runtime_dependencies = ['nokogiri']                        
  p.development_dependencies = ['shoulda', 'fakeweb']
  p.retain_gemspec = true
  p.rcov_options = "--exclude 'gems/*'"
end
