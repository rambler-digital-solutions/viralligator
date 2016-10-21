require 'uri'
require 'thrift'

$:.push(File.expand_path('viralligator', File.dirname(__FILE__)))
require 'viralligator/viralligator'

module Viralligator
  class Configuration
    ##
    # Usage:
    #  Viralligator::Configuration.config do |config|
    #    config.dsn='//s1.viralligator.rns.online:2112'
    #  end
    #
    def self.config
      yield(self)
    end

    def self.dsn=(dsn)
      # check assigned DSN
      @dsn = URI(dsn).to_s
    end

    def self.dsn
      @dsn || '//s1.viralligator.rns.online:2112'
    end
  end

  def self.client
    @client ||= ::Viralligator::Adapter
              .new(::Viralligator::Configuration.dsn)
              .tap { |adapter| adapter.open_connect }
              .client
  end

  class Adapter
    def initialize(uri)
      uri = URI(uri)
      @transport = ::Thrift::FramedTransport.new(Thrift::Socket.new(uri.host, uri.port))
    end

    def client
      @client ||= ::Viralligator::Client.new(protocol)
    end

    def protocol
      @protocol ||= ::Thrift::BinaryProtocol.new(@transport)
    end

    def open_connect
      @transport.open
    end

    def close_connect
      @transport.close
    end
  end
end
