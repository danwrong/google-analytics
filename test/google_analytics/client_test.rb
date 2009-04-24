require File.join(File.dirname(__FILE__), '../test_helper')

class ClientTest < Test::Unit::TestCase
  
  context 'given an instance of Client' do
    setup do
      @client = GoogleAnalytics::Client.new('user', 'password')
    end
    
    should 'attempt login if before API call if no auth token set'
    
    should 'send a login request with the username and password in the body'
    
    should 'make get request containing the auth header'
    
    should 'make get request with the correct query string arguments'
  end
  
end