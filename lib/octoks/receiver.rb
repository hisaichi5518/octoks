require 'rack'
require 'json'
require 'openssl'
require 'secure_compare'

module Octoks
  class Receiver
    attr_accessor :hooks
    attr_reader   :secret

    def initialize(secret = nil)
      @hooks  = {}
      @secret = secret
    end

    def on(name, &cb)
      @hooks[name] ||= []
      @hooks[name].push(cb)
    end

    def emit(event)
      hooks[event.name] ||= []
      hooks[event.name].each do |hook|
        hook.call(event)
      end
    end

    def call(env)
      req    = Rack::Request.new(env)
      failed = [400, [], ["BAD REQUEST"]]

      if !req.post? or req.params['payload'].nil? or req.env["HTTP_X_GITHUB_EVENT"].nil?
        return failed
      end

      unless verify_signature(req)
        return failed
      end

      begin
        payload = JSON.parse(req.params['payload'])
      rescue
        return failed
      end

      event_name = req.env["HTTP_X_GITHUB_EVENT"]
      event      = Octoks::Event.new(event_name.to_sym, payload)

      emit(event)

      [200, [], ["OK"]]
    end

    HMAC_DIGEST = OpenSSL::Digest.new('sha1')
    def verify_signature(req)
      return true unless @secret
      return false unless req.body
      sig = 'sha1='+OpenSSL::HMAC.hexdigest(HMAC_DIGEST, @secret, req.body.read)
      req.body.rewind
      SecureCompare.compare(sig, req.env["HTTP_HUB_SIGNATURE"])
    end

  end
end
