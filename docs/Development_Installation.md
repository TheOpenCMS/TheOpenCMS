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

### Configure ENV params

```
...
```

### Create development seeds

```
rake dev_seeds:fakes USERS=30
```

### Launch web server

```
rails s
```

or

```
rvmsudo rails server -p 80
```
