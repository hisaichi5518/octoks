# Octoks

Octoks is Github Hooks Receiver. inspired by `GitHub::Hooks::Receiver`

https://github.com/Songmu/Github-Hooks-Receiver

## Installation

Add this line to your application's Gemfile:

    gem 'octoks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octoks

## Usage

```ruby
# this file name is `config.ru`
require 'octoks'

receiver = Octoks::Receiver.new
receiver.on :push do |event|
  # event is Octoks::Event object
  p event.name
  p event.payload
end

run receiver
```

And `rackup`

```sh
# run receiver
rackup config.ru
```

You can check the following hook name.
https://developer.github.com/v3/activity/events/types/

## Contributing

1. Fork it ( http://github.com/hisaichi5518/octoks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
