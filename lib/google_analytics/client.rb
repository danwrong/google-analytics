require 'net/http'
require 'net/https'
require 'uri'
require 'nokogiri'

module GoogleAnalytics
  
  AUTH_URL = 'https://www.google.com/accounts/ClientLogin'
  BASE_URL = 'https://www.google.com/analytics'
  
  class NotAuthorized < StandardError; end
  class ResponseError < StandardError; end
  
  class Client
    
    def initialize(username, password)
      @username, @password = username, password
    end
    
    def login!
      data = {
        :accountType => 'GOOGLE_OR_HOSTED',
        :service     => 'analytics',
        :Email       => @username,
        :Passwd      => @password
      }
      
      resp = request(URI.parse(AUTH_URL), :post, data)
      
      begin
        if resp =~ /^Auth\=(.+)$/
          @auth = $1
        else
          raise NotAuthorized, 'you cannot access this google account'
        end
      rescue ResponseError
        raise NotAuthorized, 'you cannot access this google account'
      end
    end
    
    def get(path, args=nil)
      api_request(path, :get, args)
    end

    def post(path, args=nil)
      api_request(path, :post, args)
    end
    
    def api_request(path, method, args)
      login! unless @auth
      url = URI.parse([BASE_URL, path].join)
      resp = request(url, method, args)
      
      Nokogiri::XML(resp)
    end

    def request(url, method=:get, data=nil)
      case method
      when :get
        url.query = encode(data) if data
        req = Net::HTTP::Get.new(url.request_uri)
      when :post
        req = Net::HTTP::Post.new(url.request_uri)
        req.body = encode(data) if data
        req.content_type = 'application/x-www-form-urlencoded'
      end
      
      req['Authorization'] = "GoogleLogin auth=#{@auth}" if @auth

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.port == 443)

      res = http.start() { |conn| conn.request(req) }
      
      raise ResponseError, "#{res.code} #{res.message}" unless res.code == '200'
      
      res.body
    end
    
    protected
    
    def encode(data)
      data.map { |k,v| "%s=%s" % [URI.encode(k.to_s), URI.encode(v.to_s)] }.join("&")
    end
    
  end

end