require 'faraday'
require 'json'
require 'ostruct'

module Wit

  class << self
    attr_accessor :token

    def token
      @token || ENV['WIT_TOKEN']
    end
  end

  def self.message(message = '')
    response = connection.get do |req|
      req.headers['Authorization'] = "Bearer #{token}"
      req.url '/message', q: message
    end

    case response.status
    when 200 then return Result.new JSON.parse(response.body)
    when 401 then raise Unauthorized, "incorrect token set for Wit.token set an env for WIT_TOKEN or set Wit::TOKEN manually"
    else raise BadResponse, "response code: #{response.status}"
    end
  end

  def self.connection
    @connection ||= Faraday.new url: 'https://api.wit.ai' do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  class Result

    attr_reader :raw, :msg_id, :msg_body, :intent, :confidence, :entities

    def initialize(hash)
      @raw = hash
      @msg_id = hash['msg_id']
      @msg_body = hash['msg_body']
      @intent = hash['outcome']['intent']
      @confidence = hash['outcome']['confidence']
      @entities = EntityCollection.new
      hash['outcome']['entities'].each do |name, entity|
        @entities.send(:"#{name}=", Entity.new(entity))
      end
    end

  end

  class EntityCollection < OpenStruct

    def [](name)
      send(name.to_sym)
    end

  end

  class Entity < OpenStruct
  end

  class Unauthorized < Exception; end
  class BadResponse < Exception; end
end
