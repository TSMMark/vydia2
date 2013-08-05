class REQUEST
  require "net/http"
  require "uri"
  def self.get_response uri
    Net::HTTP.get_response(parse_uri(uri))
  end
  def self.response_body uri
    get_response(uri).body
  end
  def self.parse_uri uri
    URI.parse(uri)
  end
end
