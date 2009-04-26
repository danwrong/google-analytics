module GoogleAnalytics
  
  class User
    
    def initialize(username, password)
      @client = Client.new username, password
    end
    
    def accounts
      return @accounts if @accounts
      xml = @client.get('/feeds/accounts/default')
      @accounts = xml.xpath('//xmlns:entry').collect do |account_node|
        Account.from_node(@client, account_node)
      end
    end
    
    def account(id)
      accounts.find do |account|
        account if account.id == id
      end
    end
    
  end

end