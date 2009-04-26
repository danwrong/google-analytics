module GoogleAnalytics
  
  class Account    
    attr_reader :url, :title, :id, :profile_id
    
    def self.from_node(client, node)
      new client, 
          node.xpath('.//xmlns:id').first.content, 
          node.xpath('.//dxp:property[@name="ga:accountName"]', 'dxp' => DXP_NAMESPACE).first.attributes['value'].to_s,
          node.xpath('.//dxp:property[@name="ga:accountId"]', 'dxp' => DXP_NAMESPACE).first.attributes['value'].to_s,
          node.xpath('.//dxp:property[@name="ga:profileId"]', 'dxp' => DXP_NAMESPACE).first.attributes['value'].to_s
    end
    
    def initialize(client, url, title, id, profile_id)
      @client, @url, @title = client, url, title
      @id, @profile_id = id, profile_id
    end
    
    def report(options={})
      
    end
    
  end

end