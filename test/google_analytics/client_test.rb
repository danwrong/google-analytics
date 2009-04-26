require File.join(File.dirname(__FILE__), '../test_helper')

class ClientTest < Test::Unit::TestCase
  
  context 'given an instance of Client' do
    setup do
      @client = GoogleAnalytics::Client.new('user', 'password')
    end
    
    should 'turn a hash into a url encoded string when encode called' do
      res = @client.send :encode, { :thing => 12, :thong => 'something with spaces' }
      assert_match /thing\=12/, res
      assert_match /thong\=something\%20with\%20spaces/, res
    end
    
    should 'send request to correct url with username and password' do
      @client.expects(:request).with(
        URI.parse(GoogleAnalytics::AUTH_URL),
        :post,
        { 
          :Email => 'user', :Passwd => 'password', 
          :accountType => 'GOOGLE_OR_HOSTED', :service => 'analytics' 
        }
      ).returns('Auth=thing')
      
      @client.login!
    end
    
    should 'raise not authorized if failed to log in' do
      @client.expects(:request).with(
        URI.parse(GoogleAnalytics::AUTH_URL),
        :post,
        { 
          :Email => 'user', :Passwd => 'password', 
          :accountType => 'GOOGLE_OR_HOSTED', :service => 'analytics' 
        }
      ).returns('fail')
      
      assert_raises GoogleAnalytics::NotAuthorized do
        @client.login!
      end
    end
    
    should 'login if auth is not set before api_request' do
      @client.instance_variable_set(:@auth, nil)
      @client.expects(:login!)
      @client.expects(:request).returns('')
      
      @client.api_request('/', :get, {})
    end
  end
  
end