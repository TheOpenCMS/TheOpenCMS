### Structure of a configuration system

:warning: Holy War alert

Ruby on Rails is a system which encourages a principle [Convention Over Configuration](http://rubyonrails.org/doctrine/#convention-over-configuration). I guess, because of that Rails still doesn't have any good way to configure middle- and big-size applications.

To be honest, I'm not satisfied by a way to configure an application which Rails uses. I mean way, when for different environments you have to put configurations in the same file. There is an example.

```yml
development:
  adapter: async

test:
  adapter: async

production:
  adapter: redis
  url: redis://10.10.3.153:6381
```

First of all, I'm pretty sure configurations for an app must be split by folders.

Also, I think, it's a good idea to split configuration files by purpose.

For TheOpenCMS I had to create my own way to configure the project.

This is how I see "right" structure of a configuration system for a Rails app.

```ruby
config/ENV/
├── development
│   ├── services
│   └── settings
└── production.example
    ├── services
    └── settings
```

For my application I have a folder with name `ENV` in the `config` folder of the project.

Folder `ENV` contains folders for each specific environment of my application (`development`, `production`, `staging` etc.).

Each folder for an environment contains folders with configuration files.

Folder `services` contains configurations for a Rails app.

Folder `settings` contains configurations for services are used by a Rails app.

There is a structure of configuration files for `development` environment.

```ruby
config/ENV/development/
├── services
│   ├── puma.rb
│   ├── redis.config
│   ├── schedule.rb
│   ├── sidekiq.yml
│   └── thinking_sphinx.yml
└── settings
    ├── app.yml
    ├── app_mailer.yml
    ├── devise.yml
    └── oauth.yml
```
