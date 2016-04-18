[![Run Status](https://api.shippable.com/projects/571523802a8192902e1d12c1/badge?branch=master)](https://app.shippable.com/projects/571523802a8192902e1d12c1) [![Coverage Badge](https://api.shippable.com/projects/571523802a8192902e1d12c1/coverageBadge?branch=master)](https://app.shippable.com/projects/571523802a8192902e1d12c1)

# README

## Contributing

1. Fork it ( https://github.com/bosskovic/fungiorbis_pure_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Development ENV setup

1. git clone git@github.com:my_username/fungiorbis_pure_rails.git
2. cd fungiorbis_pure_rails
3. rvm gemset use fungiorbis2
4. bundle install
5. address any missing dependencies reported in the step 4
6. setup the dev database in config/database.yml
7. ./dbsetup.sh
8. rails s
