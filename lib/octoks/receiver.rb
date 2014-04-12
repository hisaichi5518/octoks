require 'rack'
require 'json'

module Octoks
  class Receiver
    attr_accessor :hooks

    def initialize
      @hooks = {}
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

      if !req.post? or req.params['payload'].nil? or req.env["X-GitHub-Event"].nil?
        return failed
      end

      begin
        payload = JSON.parse(req.params['payload'])
      rescue
        return failed
      end

      event_name = req.env["X-GitHub-Event"]
      event      = Octoks::Event.new(event_name.to_sym, payload)

      emit(event)

      [200, [], ["OK"]]
    end
  end
end
