# Slate

Logging and Metrics with common format for easier splunking.

Slate comes in two main but related parts - Logging and Metrics. There's also a few utils that help with each. So far it's bare bones and in a state of flux as we learn more about our logging patterns, specifically at this point around Splunk.

## Configuration

Add config/log4r.yml to your app. This could arguably live inside Slate and may be moved at some stage. The minimum required config is as follows

```
loggers:
  - name: default
    level: DEBUG
    trace: true
    outputters:
    - application_log
  - name: metrics
    level: DEBUG
    trace: true
    outputters:
    - application_log

# define all outputters (incl. formatters)
outputters:
- type: FileOutputter
  name: application_log
  filename: 'log/application-#{ENV}.log'
  trunc: false
  formatter:
    date_pattern: '%Y-%m-%dT%H:%M:%S%z'
    pattern: '%d %l (%t): pid=%p, %m'
    type: PatternFormatter
- type: StdoutOutputter # Used in dev mode only
  name: console_log
  formatter:
    pattern: '%m'
    type: PatternFormatter
```

### Setting the logger on libs
Some libs will allow injection of the logger or metrics. For example, the http_api_gem can have this set. A reasonable pattern for this is to create `config/initializers/slate.rb` and add the following:

```ruby
HttpApiClient.logger = Slate::Logger
HttpApiClient.metrics = Slate::Metrics
```

Obviously different libraries will have different ways of configuring a logger.

## Request Id Tracking
In order to track the Request Id through logs and metrics, add the following to your application_controller or another suitable controller base class.

```ruby
include Slate::Controller::RequestIdManager
```

This will add a thread local variable keyed under `:request_id` with the current rails managed request id if present or generate one if not. Note that if the request has an `X-Request-Id` header present, this will be used. This makes tracking request id through service based applications possible.

### Request Id and Threads
Because the request is is tracked via a threadlocal variable, it needs to be passed into threads if it's to be referenced. At this point, the only baked-in support for this is for Celluloid futures.

To get automatic passing of request id into celluloid futures you can mix the `Slate::FutureFactory` into your class and create your futures via `traceable_future`.

```ruby
include Slate::FutureFactory

def my_future_method
  traceable_future do
    # do something in a thread
    # return something
  end
end
```

## Metrics

### Timer

```ruby
timed_result = Slate::Metrics.time('timed_event_name', { foo: 'bar' }) do
  # do somthing
  # return something
end
```

Wrap a block for logging timings in a consistent format. All timings are logged with the format:

```
event_name=timed_event_name, timing=100, foo=bar, request_id=292f7352-4a38-494a-8f9c-c12fba5a5e57
```

The second argument can take a hash of name value pairs to be logged. If a request id is present on the current thread, this will be appended as well.

### Timing Controller Actions

Timing requests at the controller level can be done by including the action timer in your controller

```ruby
include Slate::Controller::ActionTimer
```
then specifying which controller actions to wrape the timings around

```ruby
around_action :time_action
```

specific actions can be specified using the regular filters declaration

```ruby
around_action :time_action, only: [:index, :show]
```

It is anticipated that the metrics side of Slate will evolve to include a few more ways of capturing metrics over time  such as guages, meters, counters etc.  Note however that the only intended output for these logs at this point is Splunk which is not purpose built for all metrics.

##Logging
Slate is intended to be used instad of the rails log and uses log4r under the covers. The standard logger interface is available (debug, info, warn, error, fatal) with a small enhancement being that either a String or Hash can be logged.

```ruby
Slate::Logger.info('Log message')
```

or

```ruby
Slate::Logger.info(foo: 'bar', baz: 'boz')
```


If a hash is passed, it will be logged in the format:

```foo=bar, baz=boz```

This format is good for parsing by splunk so is generally preferable to log messages that pass an arbitrary string.
