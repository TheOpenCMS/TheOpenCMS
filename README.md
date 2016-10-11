## Deploy.RB / Rails 5 App

This is a part of the [Deploy.RB](https://deployrb.github.io/) project.

Deploy.RB consists of:

1. [Rails 5 App](https://github.com/DeployRB/Rails5App) (**You are here**)
2. [Server Installation Script & Manual](https://github.com/DeployRB/SetupServer)
3. [Deployment Tool](https://github.com/DeployRB/DeployTool)

Please, visit [Deploy.RB](https://deployrb.github.io/) page to get more information.

```
```

# Rails 5 App

Simple Rails 5 App for `deploy.rb` project

With this App we demonstrate how basic Rails 5 can be configurated for deployment process

The app uses the following tools:

* PostgreSQL (as main DB Storage)
* Devise (Authentication)
* Redis (Cache store and store for SideKiq)
* SideKiq (Delayed jobs)
* Thinking Sphinx (Full-text search)
* `mysql2` adapter to work with `Thinking Sphinx`
* `foreman` to start/stop services
* WebSockets (ActionCable)
* Whenever (Cron tasks)
* `kaminari` for pagination

## How to run on local machine

### System requirements

- Unix like OS
- NodeJS (https://nodejs.org)
- Redis (http://redis.io)
- Sphinx (http://sphinxsearch.com)
- PostgreSQL (http://postgresql.org)
- MySQL (http://mysql.com)

<details>
  <summary>[open ▾] How to check required software?</summary>

```
$ which rvm
/Users/$HOME/.rvm/bin/rvm

$ which node
/usr/local/bin/node

$ which redis-server
/usr/local/bin/redis-server

$ which searchd
/usr/local/bin/searchd

$ which psql
/usr/local/bin/psql

$ which mysql
/usr/local/bin/mysql
```

</details>

### 1. Clone & install

```sh
git clone https://github.com/DeployRB/Rails5App.git
cd Rails5App

gem install bundler
bundle install
```

### 2. Create a folder for config files for your environment

```
cp -av config/ENV/production.example config/ENV/development
```

### 3. Edit files in folders were copied

0. Edit files were copied and replace `/ABS/PATH/TO` with real absolute path to your `Rails5App` app path

    For example, `/ABS/PATH/TO/Rails5App` => `/Users/the-teacher/rails/Rails5App`

0. Edit files were copied and replace `production.example` with a name of your environment

  For example:

  ```sh
    sed -i '' 's/production.example/development/g' config/ENV/development/services/*
  ```

### 4. Setup `database.yml`

```sh
cp config/database.yml.example config/database.yml
```

Edit file and set required parameters.

<details>
  <summary>[open ▾] How to create PQSL user?</summary>

```ruby
createuser rails5app -sW
> qwerty
```

```sql
psql -U postgres

CREATE USER "rails5app" WITH PASSWORD 'qwerty';
ALTER ROLE "rails5app" SUPERUSER CREATEDB;

\q
```

</details>

### 5. Initialize your App

```
bundle exec rake app:init
```

### 6. Build Search index

```
bundle exec rake ts:configure ts:index
```

### 7. Start services

Start cron tasks

<details>
  <summary>[open ▾] CRON. Notes</summary>

* tasks list `crontab -l`
* remove all tasks `crontab -r`

```sh
bundle exec whenever --clear-crontab Rails5App
```
</details>

```sh
bundle exec whenever --update-crontab \
  -i Rails5App \
  --load-file config/ENV/development/services/schedule.rb \
  --set 'environment=development'
```

Start services with `foreman`

```
bundle exec foreman start
```

### 8. Start Rails server

```
bundle exec puma -b tcp://localhost -p 3000
```

or just

```
bundle exec rails s
```

### Finally App is ready to use

```
http://localhost:3000
```

### Async tasks

```
http://localhost:3000/async/tasks
```

```
login: admin
password: qwerty
```
