require 'minitest/autorun'
require 'octoks'

class TestReceiver < MiniTest::Unit::TestCase
  def test_call
    receiver = Octoks::Receiver.new("secret1234")
    env = {
      'rack.version'           => [1, 2],
      'REQUEST_METHOD'         => 'POST',
      'SERVER_NAME'            => 'example.com',
      'SERVER_PORT'            => 80,
      'QUERY_STRING'           => '',
      'PATH_INFO'              => '/',
      'rack.url_scheme'        => 'http',
      'HTTPS'                  => 'off',
      'CONTENT_LENGTH'         => 15,
      'rack.input'             => StringIO.new('payload={"hoge":"fuga"}'),
      'HTTP_X_GITHUB_EVENT'    => 'issue',
      'HTTP_HUB_SIGNATURE'     => 'sha1=b2d620dd0b514b814685364d637058fe5ce29479',
      'HTTP_X_GITHUB_DELIVERY' => 'gggg',
    }
    res = receiver.call(env)
    assert_equal 200, res[0]

    env['HTTP_HUB_SIGNATURE'] += "fail!"
    res = receiver.call(env)
    assert_equal 400, res[0]
  end

end
