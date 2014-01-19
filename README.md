# Gitpeach

## Setup
```sh
bundle install --path vendor/bundle
cp config/database.yml{.sample,}
vi config/database.yml
cp config/gitlab.yml{.sample,}
vi config/gitlab.yml
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
