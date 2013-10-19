wit-ruby
========

[![Gem Version](https://badge.fury.io/rb/wit-ruby.png)](http://badge.fury.io/rb/wit-ruby)

Easy interface for interacting with the [Wit.ai](http://wit.ai) natural language parsing API.

This project will expand as the Wit.ai API expands, but as it stands there's a single endpoint. You can hit this
endpoint easily with `Wit.message([your message])`, which uses Wit.ai to convert that phrase or sentence into an object
with an intent, and entities if any are available.

You will need to create a Wit.ai account and begin training it.

## Installation

```ruby
gem 'wit-ruby', '>= 0.0.2'
```

You'll need to set an environment variable named `WIT_TOKEN` or specify your token with `Wit.token = [your token]`.

```shell
export WIT_TOKEN=[your token]
```


## Usage

```ruby
result = Wit.message('Hi')
result.intent # will be Hello with the default Wit instance.
result.confidence # will be relatively low initially.
result.entities # will be {}, but if there are entities the can accessed as [:name] or .name
```

### Result properties/methods

<dl>

<dt> raw </dt><dd>
Raw response hash (parsed JSON)
</dd>

<dt> msgId </dt><dd>
The unique message id provided back from Wit.
</dd>

<dt> msgBody </dt><dd>
The original message sent.
</dd>

<dt> intent </dt><dd>
The intent, as determined by Wit.
</dd>

<dt> confidence </dt><dd>
The confidence level that Wit determined.
</dd>

<dt> entities </dt><dd>
Hash of entities, which contain the value, and the start/end position within msgBody.
</dd>

</dl>

### Entity properties/methods

<dl>

<dt> value </dt><dd>
The value as determined by Wit (might not be the same as body).
</dd>

<dt> start </dt><dd>
The start position index from msgBody.
</dd>

<dt> end </dt><dd>
The end position index from msgBody.
</dd>

<dt> body </dt><dd>
The actual value as specified in msgBody.
</dd>

</dl>


## License

Licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)

Copyright 2012 [Mode Set](https://github.com/modeset)


## Make Code Not War
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)
