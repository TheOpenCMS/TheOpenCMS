[&larr; Docs](./README.md)

```
```

## Development Installation

### Clone the project

```sh
git clone git@github.com:TheOpenCMS/TheOpenCMS.git

cd TheOpenCMS
```

### Install gems

```sh
gem install bundler

bundle install
```

### Configure DB adapter

```sh
cp config/database.yml.example config/database.yml
```

Edit configuration file

```yaml
development:
  adapter: postgresql
  encoding: unicode
  database: the_open_cms_dev
  pool: 5
  username: username
  password: qwerty
```

### Create a folder for config files for your environment

```
cp -av config/ENV/production.example config/ENV/development
```

### Edit files in folders were copied

0. Edit files were copied and replace `/ABS/PATH/TO` with real absolute path to your `Rails5App` app path

    For example, `/ABS/PATH/TO/Rails5App` => `/Users/the-teacher/rails/Rails5App`

0. Edit files were copied and replace `production.example` with a name of your environment

  For example:

  ```sh
    sed -i '' 's/production.example/development/g' config/ENV/development/services/*
  ```

### Create development seeds

```
rake dev_seeds:fakes USERS=30
```

### Check App Settings

```
rails c
```

```
puts puts Settings.to_hash.deep_stringify_keys.to_yaml
```

You will see something like this:

```yaml
app:
  default_locale: en
  time_zone: St. Petersburg
  secret_key_base: a000000000000000000000000000000000000000000000000001
  secret_token: a000000000000000000000000000000000000000000000000002
  mailer:
    service: letter_opener
    host: http://localhost:3000
    admin_email: admin@theopencms.com
    smtp:
      default:
        user_name: no-reply@theopencms.org
        password: XXXXXXXXXXXXXXXXXXXXXXXXX
        authentication: plain
        enable_starttls_auto: true
        address: smtp.yandex.ru
        domain: yandex.ru
        port: 25
    sandmail:
      location: "/usr/sbin/sendmail"
      arguments: "-i -t"
    mailcatcher:
      address: localhost
      port: 1025
  exception_notification:
    app_name: "[TheOpenCMS.org]"
    sender_name: "[TheOpenCMS Errors]"
    sender_address: no-reply@theopencms.org
    recipient_address: errors@theopencms.org
redis:
  port: 6010
  url: redis://localhost:6010/1
sidekiq:
  namespace: example.com
  ui:
    user: admin
    password: qwerty
action_cable:
  adapter_params:
    adapter: redis
    url: redis://localhost:6010/1
    channel_prefix: rails5app
  worker_pool_size: 4
  mount_path: ws://localhost:3000/app-cable
  disable_request_forgery_protection: false
  allowed_request_origins: http://localhost:3000
devise:
  mailer_sender: mail-sender@example.com
  parent_mailer: ActionMailer::Base
  mailer: DeviseMailer
oauth:
  facebook:
    tokens:
    - 00000000000000
    - 000000000000000000000000000000000000000000
    options:
      scope: email,public_profile,user_friends
      info_fields: name,email,cover,link
      display: popup
  twitter:
    tokens:
    - 00000000000000
    - 000000000000000000000000000000000000000000
  google_oauth2:
    tokens:
    - 000000000000000000000000000000000000000000.apps.googleusercontent.com
    - 0000000000000000000000000000
    options:
      scope: email, profile, plus.me
      prompt: select_account
      image_aspect_ratio: square
      image_size: 50
      display: popup
      skip_jwt: true
  vkontakte:
    tokens:
    - 00000000000000
    - 0000000000000000000000000000
    options:
      display: popup
  odnoklassniki:
    tokens:
    - 00000000000000
    - 0000000000000000000000000000
    options:
      public_key: 00000000000000
      scope: VALUABLE_ACCESS
services:
  rollbar:
    token: ''
  google_analytics:
    tracking_id: ''
  yandex_metrika:
    tracking_id: ''
```

### Launch Application Web Server

```
rails s
```

or for port `80`

```
rvmsudo rails server -p 80
```

### Visit Browser

```
localhost:3000
```
