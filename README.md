# Calltally::Erb

ERB support plugin for [Calltally](https://github.com/nsgc/calltally).

## Installation

First, install Calltally if you haven't already:

```bash
gem install calltally
```

Then install this plugin:

```bash
gem install calltally-erb
```

Or add both to your Gemfile:

```ruby
gem 'calltally'
gem 'calltally-erb'
```

## Usage

Once installed, calltally-erb automatically registers itself as a plugin. You can then use the `--plugins` flag with calltally to analyze ERB files:

```bash
calltally --plugins erb
```

This will include `.erb` files in the analysis and extract Ruby code from them for method call analysis.


Or specify it in `.calltally.yml`:

```yaml
plugins:
  - erb
```

## How it works

This plugin uses the [herb](https://github.com/marcoroth/herb) gem to parse ERB files and extract Ruby code. The extracted Ruby code is then analyzed by Calltally's standard Ruby parser.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nsgc/calltally-erb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
