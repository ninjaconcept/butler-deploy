# Butler::Deploy

Setup a fully working capistrano deployment. It assumes having a user account named `deploy` on the server. Also it assumes that the application gets deployed to `~/www/APPLICATION_NAME/`.

Deployment uses bundler, chruby and unicorn. After generating the configuration everything can be changed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'butler-deploy', git: 'git@github.com:ninjaconcept/butler-deploy.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install butler-deploy

## Usage

```bash
rails g butler:deploy:install --app-name=my-app --production-host=host.ninjaconcept.com
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Todo

See issues list:
https://github.com/ninjaconcept/butler-deploy/issues

## Contributing

1. Fork it ( https://github.com/[my-github-username]/butler-deploy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
