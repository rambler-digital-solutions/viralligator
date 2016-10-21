$:.push('gen-rb')

require "ruby_client/version"
require 'thrift'
require 'viralligator'

module RubyClient
  # Your code goes here...
  class Example
    URL_SERVICE = 's1.viralligator.rns.online'

    def initialize(url = URL_SERVICE)
      @transport = Thrift::FramedTransport.new(Thrift::Socket.new(url, 2112))
    end

    def client
      @client ||= ::Viralligator::Client.new(protocol)
    end

    def protocol
      @protocol ||= Thrift::BinaryProtocol.new(@transport)
    end

    def open_connect
      @transport.open
    end

    def close_connect
      @transport.close
    end
  end
end
