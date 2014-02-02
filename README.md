# Gitpeach

## Setup
### Signup to [Pusher](https://app.pusher.com/)
Create new app
![Create new app](http://cdn-ak.f.st-hatena.com/images/fotolife/s/sue445/20140121/20140121234019.png)

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