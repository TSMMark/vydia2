module RailsExtensions
  
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

  class ::Range
    def sample *p
      self.to_a.sample *p
    end
  end

  class ::String
    
    require "uri"
    def uri?
      uri = URI.parse(self)
      %w( http https ).include?(uri.scheme)
    rescue URI::BadURIError
      false
    rescue URI::InvalidURIError
      false
    end

    def numeric?
      self.match(/^[0-9]+\z/)
    end

    def positive_integer?
      self.to_i.positive?
    end

    def negative_integer?
      self.to_i.negative?
    end

    def nonnegative_integer?
      !self.to_i.negative?
    end


    # parameters / arguments
    def cgi_escape!
      # self._replace_all! CGI::escape(self)
      self._replace_all! self.cgi_escape
    end
    def cgi_escape
      CGI::escape self
    end
    def _replace_all! s
      self.gsub! /(.+)/, s
      self
    end

  end

  class ::Fixnum
    def positive?
      self > 0
    end
    def zero?
      self == 0
    end
    def negative?
      self < 0
    end
    def non_negative?
      !negative?
    end
  end

  class ::Float
    def rount_to n=0
      (self * (10.0 ** n)).round * (10.0 ** (-n))
    end
    def positive?
      self > 0
    end
    def zero?
      self == 0
    end
    def negative?
      self < 0
    end
    def non_negative?
      !negative?
    end
  end

  class ::Symbol
    def constantize camel=true
      s = self.to_s
      s = s.camelize if camel
      s.constantize
    end
  end


  #    Class    #
  class ::Class
    # underscore and convert class name to symbol
    def name_to_sym
      self.name.underscore.to_sym
    end
  end
  # .. Class .. #

  #    Object    #
  class ::Object
    # if self is a proc call it with params, otherwise just return self
    def call_or_value *params
      return self.call(*params) if self.is_a? Proc
      self
    end
    
    # class_name_to_sym
    def class_name_to_sym
      self.class.name.underscore.to_sym
    end

    # raises object to_yaml
    def ryaml
      raise self.to_yaml
    end

    def make_array
      return self if self.is_a? Array
      return [self]
    end
  end
  # .. Object .. #


  #    Hash    #
  class ::Hash

    # bang fill hash with default values
    def fill_with!(default=nil, keys=nil)
      if !keys then
        self.each_key {|key| self[key]  = default}
      elsif keys.is_a? Array
        keys.each     {|key| self[key]  = default}
      else
        self[keys]  = default
      end
      self
    end
    # fill hash with default values
    def fill_with(default=nil, keys=nil)
      a = self.clone
      a.fill_with!(default, keys)
      a
    end

    # delete from this hash, a list of keys
    def delete_keys! list
      if list.is_a? Array
        list.map{|k| self.delete k}
      else
        self.delete list
      end
      self
    end
    def delete_keys list
      self.clone.delete_keys! list
    end

    # returns only the key/value pairs where the key is in the matching array
    #   DISABLED UNTIL SPEC
    # def filter_against (matching, sensitive=false)
    #   myself = self
    #   final  = {}
    #   if(!sensitive) then
    #     myself = myself.insensitive
    #     final  = final.insensitive
    #   end
      
    #   # return complete hash if (matching==true)
    #   return self if(matching==true)
    #   # return empty hash if (matching==false)
    #   return {}   if(matching==false)
      
    #   final.tap do |final|
    #     matching.each do |key|
    #       final[key] = myself[key] if myself.has_key?(key)
    #     end
    #   end
    # end

  end
  # .. Hash .. #



end