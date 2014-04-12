require 'minitest/autorun'
require 'octoks'

class TestReceiver < MiniTest::Unit::TestCase
  def test_on
    receiver = Octoks::Receiver.new
    receiver.on :push do |event|
    end
    receiver.on :push do |event|
    end

    assert_equal receiver.hooks[:push].size, 2
  end

  def test_emit
    receiver = Octoks::Receiver.new
    receiver.on :push do |event|
      event.payload["count"] = 1
    end
    receiver.on :push do |event|
      event.payload["count"] += 1
    end

    event = Octoks::Event.new(:push, {"test" => "test"})
    receiver.emit(event)

    assert_equal event.payload["count"], 2
  end
end
