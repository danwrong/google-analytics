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
      data = {
        :ids => "ga:#{profile_id}",
        :metrics => ga_prefix(options.delete(:metrics)),
        :dimensions => ga_prefix(options.delete(:dimensions)),
        :'start-date' => date_format(options.delete(:start) || one_month_ago),
        :'end-date' => date_format(options.delete(:end) || Time.now),
      }
      
      data.merge!(options)
  
      @client.get('/feeds/data', data)
    end
    
    protected
    
    def ga_prefix(data)
      if data.is_a?(Array)
        data.collect { |d| "ga:#{d}" }
      elsif !data.nil?
        "ga:#{data}"
      end
    end
    
    def date_format(date)
      if date.nil?
        nil
      else
        date.strftime('%Y-%m-%d')
      end
    end
    
    def one_month_ago
      Time.now - (28 * 24 * 60 * 60)
    end
     
  end

end