## Deploy Tool documentation

### Let's encrypt (root)

#### Install

```ruby
apt-get install letsencrypt -t jessie-backports
```

## Obtain a new cert

```ruby
/etc/init.d/nginx stop

letsencrypt certonly -n --standalone -d example.com --agree-tos --email user@gmail.com

/etc/init.d/nginx start

cp /etc/letsencrypt/live/example.com/privkey.pem /home/rails/www/example.com/production/SSL/
cp /etc/letsencrypt/live/example.com/fullchain.pem /home/rails/www/example.com/production/SSL/

chown  rails:rails /home/rails/www/example.com/production/SSL/*
chown  rails:rails /home/rails/www/example.com/production/SHARED/log/letsencrypt.*
```

## Renew certs

**lets_encript.sh**

```ruby
echo '==============================================================================='
date
echo '==============================================================================='
certbot renew --pre-hook "service nginx stop" --post-hook "service nginx start"

cp /etc/letsencrypt/live/example.com/privkey.pem /home/rails/www/example.com/production/SSL/
cp /etc/letsencrypt/live/example.com/fullchain.pem /home/rails/www/example.com/production/SSL/
chown  rails:rails /home/rails/www/example.com/production/SSL/*
```

**crontab -e**

**/var/spool/cron/crontabs/root**

Check everyday _at 11:58, 23:58 everyday_

```ruby
58 11,23 * * * /bin/bash -l -c 'source lets_encript.sh >> /home/rails/www/example.com/production/SHARED/log/letsencrypt.log 2>> /home/rails/www/example.com/production/SHARED/log/letsencrypt.errors.log'
```
