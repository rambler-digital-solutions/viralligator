#
# Autogenerated by Thrift Compiler (0.9.3)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

class Share
  include ::Thrift::Struct, ::Thrift::Struct_Union
  SOCIAL = 1
  COUNT = 2

  FIELDS = {
    SOCIAL => {:type => ::Thrift::Types::STRING, :name => 'social'},
    COUNT => {:type => ::Thrift::Types::I64, :name => 'count'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

class TotalShare
  include ::Thrift::Struct, ::Thrift::Struct_Union
  URL = 1
  COUNT = 2

  FIELDS = {
    URL => {:type => ::Thrift::Types::STRING, :name => 'url'},
    COUNT => {:type => ::Thrift::Types::I64, :name => 'count'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

class Sharing
  include ::Thrift::Struct, ::Thrift::Struct_Union
  URL = 1
  SHARES = 2

  FIELDS = {
    URL => {:type => ::Thrift::Types::STRING, :name => 'url', :optional => true},
    SHARES => {:type => ::Thrift::Types::LIST, :name => 'shares', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Share}, :optional => true}
  }

  def struct_fields; FIELDS; end

  def validate
  end

  ::Thrift::Struct.generate_accessors self
end

