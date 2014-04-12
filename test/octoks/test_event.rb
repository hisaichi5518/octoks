require 'minitest/autorun'
require 'octoks'

class TestEvent < MiniTest::Unit::TestCase
  def test_name
    event = Octoks::Event.new(:name, {"test" => "test"})
    assert_equal event.name, :name
  end

  def test_payload
    event = Octoks::Event.new(:name, {"test" => "test"})
    assert_equal event.payload, {"test" => "test"}
  end
end
