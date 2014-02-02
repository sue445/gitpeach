# Gitpeach [![Build Status](https://travis-ci.org/sue445/gitpeach.png)](https://travis-ci.org/sue445/gitpeach) [![Coverage Status](https://coveralls.io/repos/sue445/gitpeach/badge.png)](https://coveralls.io/r/sue445/gitpeach) [![Dependency Status](https://gemnasium.com/sue445/gitpeach.png)](https://gemnasium.com/sue445/gitpeach) [![Code Climate](https://codeclimate.com/github/sue445/gitpeach.png)](https://codeclimate.com/github/sue445/gitpeach)
[waffle.io](https://waffle.io/) clone for [Gitlab](http://gitlab.org/)

![Gitpeach](https://raw.github.com/sue445/gitpeach/master/shots/gitpeach.gif)

## Requirements
* ruby 2.0.0+
* MySQL or PostgreSQL
* Pusher

## Setup
### Signup to [Pusher](https://app.pusher.com/)
Create new app

![Pusher](https://raw.github.com/sue445/gitpeach/master/shots/pusher.png)

### Setup command
```sh
bundle install --path vendor/bundle

# Mysql
cp config/database.yml{.mysql,}

# PostgreSQL
cp config/database.yml{.postgresql,}

cp config/gitlab.yml{.sample,}
cp config/pusher.yml{.sample,}
vi config/database.yml
vi config/gitlab.yml
vi config/pusher.yml
bundle exec rake db:create
bundle exec rake db:migrate RAILS_ENV=development

bundle exec rails s
open http://localhost:3000/
```

## Test
```sh
bundle exec rake db:migrate RAILS_ENV=test
bundle exec rspec
```

## Sample scripts
see [lib/support](lib/support)

## FAQ
### Q. Why Peach?
A. Gitlab -> Git love -> Momozono Love -> Cure Peach

Detail: http://en.wikipedia.org/wiki/Fresh_Pretty_Cure!
