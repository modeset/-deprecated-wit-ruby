require 'net/http'
require 'json'

module Wit

  TOKEN = ENV['WIT_TOKEN']

  def self.message(message = '')
    uri = URI("https://api.wit.ai/message?q=#{URI.escape(message)}")
    http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{TOKEN}"
      http.request(req)
    end

    if http.is_a?(Net::HTTPUnauthorized)
      raise Unauthorized, "incorrect token set for Wit::TOKEN set an env for WIT_TOKEN or set Wit::TOKEN manually"
    end

    if http.is_a?(Net::HTTPSuccess)
      return Response.new(JSON.parse(http.body))
    end

    false
  end

  class Response

    attr_reader :raw, :msg_id, :msg_body, :intent, :confidence, :entities

    def initialize(hash)
      @raw = hash
      @msg_id = hash['msg_id']
      @msg_body = hash['msg_body']
      @intent = hash['outcome']['intent']
      @confidence = hash['outcome']['confidence']
      @entities = {}
      hash['outcome']['entities'].each do |name, entity|
        @entities[name.to_sym] = Entity.new(entity)
      end
    end

  end

  class Entity

    attr_reader :start, :end, :value, :body

    def initialize(hash)
      @start = hash['start']
      @end = hash['end']
      @value = hash['value']
      @body = hash['body']
    end

  end

  class Unauthorized < Exception; end
end
