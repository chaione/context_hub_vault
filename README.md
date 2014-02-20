# ContextHubVault

[![Code Climate](https://codeclimate.com/github/chaione/context_hub_vault.png)](https://codeclimate.com/github/chaione/context_hub_vault/badges)

[![Build Status](https://travis-ci.org/chaione/context_hub_vault.png?branch=master)](https://travis-ci.org/chaione/context_hub_vault)

Ruby client for the ContextHUB vault

## Installation

Add this line to your application's Gemfile:

    gem 'context_hub_vault'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install context_hub_vault

## Usage

```ruby
client = ContextHubVault::Client.new(host: 'http://localhost:3000', app_id: '1', auth_token: ENV['AUTH_TOKEN'])

c.create('music', name: 'Miles Davis', style: 'jazz')

c.create('music', name: 'Monk', style: 'jazz')

jazz_musicians = c.search(style: 'jazz')
```

## Docs

[http://chaione.github.io/context_hub_vault/](http://chaione.github.io/context_hub_vault/)

## Contributing

1. Fork it ( http://github.com/<my-github-username>/context_hub_vault/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
