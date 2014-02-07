# Gitpeach [![Build Status](https://travis-ci.org/sue445/gitpeach.png)](https://travis-ci.org/sue445/gitpeach) [![Coverage Status](https://coveralls.io/repos/sue445/gitpeach/badge.png)](https://coveralls.io/r/sue445/gitpeach) [![Dependency Status](https://gemnasium.com/sue445/gitpeach.png)](https://gemnasium.com/sue445/gitpeach) [![Code Climate](https://codeclimate.com/github/sue445/gitpeach.png)](https://codeclimate.com/github/sue445/gitpeach)
[waffle.io](https://waffle.io/) clone for [Gitlab](http://gitlab.org/)

![Gitpeach](https://raw.github.com/sue445/gitpeach/master/shots/gitpeach.gif)

## Requirements
* Gitlab API 5.3.0+ and 6.0.x and 6.2.0+
  * **only 6.1.0** is not supported
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
### Q. Difference with waffle.io
1. realtime updates
  * using websocket
2. show milestone
  * ![Milestone](https://raw.github.com/sue445/gitpeach/master/shots/milestone.png)

### Q. Why Peach?
A. Gitlab -> Git love -> Momozono Love -> Cure Peach

Detail: [Fresh Pretty Cure! - Wikipedia](http://en.wikipedia.org/wiki/Fresh_Pretty_Cure!)

### Q. I want to change color
1. open [bootstrap_and_overrides.css.less](app/assets/stylesheets/bootstrap_and_overrides.css.less)
2. edit `@seed-color`
  * ref. http://rriepe.github.io/1pxdeep/
