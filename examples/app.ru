require 'octoks'

receiver = Octoks::Receiver.new

receiver.on :push do |event|
  p event.name
  p event.payload
  # ...
end

run receiver
