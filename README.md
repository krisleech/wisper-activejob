# Wisper::ActiveJob

Provides [Wisper](https://github.com/krisleech/wisper) with asynchronous event
publishing using
[ActiveJob](https://github.com/rails/rails/tree/master/activejob).

[![Gem Version](https://badge.fury.io/rb/wisper-activejob.png)](http://badge.fury.io/rb/wisper-activejob)
[![Code Climate](https://codeclimate.com/github/krisleech/wisper-activejob.png)](https://codeclimate.com/github/krisleech/wisper-activejob)
[![Build Status](https://travis-ci.org/krisleech/wisper-activejob.png?branch=master)](https://travis-ci.org/krisleech/wisper-activejob)
[![Coverage Status](https://coveralls.io/repos/krisleech/wisper-activejob/badge.png?branch=master)](https://coveralls.io/r/krisleech/wisper-activejob?branch=master)

## Installation

```ruby
gem 'wisper-activejob'
```

## Usage

```ruby
publisher.subscribe(MyListener, async: true)
```

The listener must be a class (or module), not an object. This is because ActiveJob
can not reconstruct the state of an object. Whereas a class has no state.

Additionally, you should also ensure that your methods used to handle events under `MyListener` are all declared as class methods:

```ruby
class MyListener
  def self.event_name
  end
end
```


When publishing events the arguments must be simple types as they need to be
serialized, or the object must include `GlobalID` such as `ActiveRecord` models.

* [ActiveJob guide](http://edgeguides.rubyonrails.org/active_job_basics.html)
* [GlobalID](https://github.com/rails/globalid)

## Compatibility

1.9.3+ including JRuby and Rubinius.

See the [build status](https://travis-ci.org/krisleech/wisper-activejob) for details.

## Contributing

Please send a [Pull Request](https://github.com/krisleech/wisper-activejob/pulls)
or an [Issue](https://github.com/krisleech/wisper-activejob/issues) to discuss
your idea first.

## Releasing

* Bump VERSION
* Push to master
* rake build
* rake release
