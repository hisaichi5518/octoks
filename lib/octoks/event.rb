module Octoks
  class Event
    attr_accessor :name, :payload

    def initialize(name, payload)
      @name    = name
      @payload = payload
    end

  end
end
