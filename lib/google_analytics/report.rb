module GoogleAnalytics
  class Report
    
    def initialize(account, options={})
      @account = account
      @options = {
        :ids => "ga:#{account.profile_id}",
        :metrics => ga_prefix(options.delete(:metrics)),
        :dimensions => ga_prefix(options.delete(:dimensions)),
        :'start-date' => date_format(options.delete(:start) || one_month_ago),
        :'end-date' => date_format(options.delete(:end) || Time.now)
      }.merge(options)
      
      if filters = options.delete(:filters)
        @options[:filters] = ga_prefix(filters)
      end
      
      if sort = options.delete(:sort)
        @options[:sort] = ga_prefix(sort)
      end
    end
    
    def each
      page = 1
      items = rows(page)
      
      while !items.empty?
        yield items.pop
        
        items = rows(page+=1) if items.empty?
      end
    end
    
    def rows(page=1, per_page=10000)
      parse_rows(get( 
        :"start-index" => start_index(page, per_page), 
        :'max-results' => per_page  
      )0)
    end
    
    def get(options={})
      @account.client.get('/feeds/data', @options.merge(options))
    end
    
    protected
    
    def start_index(page, per_page)
      ((page - 1) * per_page) + 1
    end
    
    def parse_rows(data)
      rows = []
      data.xpath('.//xmlns:entry').each do |node|
        row = {}
        
        node.xpath('./dxp:dimension').each do |dim|
          row[strip_prefix(dim.attributes['name'])] = dim.attributes['value'].to_s
        end
        
        node.xpath('./dxp:metric').each do |dim|
          row[strip_prefix(dim.attributes['name'])] = dim.attributes['value'].to_s
        end
        
        rows << row
      end
      return rows
    end
    
    def strip_prefix(name)
      name.to_s.gsub(/^ga\:/, '')
    end
    
    def ga_prefix(data)
      if data.is_a?(Array)
        data.collect { |d| d.gsub(/(-?)(\w+)/, "\\1ga:\\2") }
      elsif !data.nil?
        d.gsub(/(-?)(\w+)/, "\\1ga:\\2")
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