class DeployKit
  def letsencript_info
    if has_letsencript?

web_domain = config.web_server.domain

puts
print "localhost$".green
print " ssh root@#{ config.ssh.user.sudo.domain }".yellow
puts
puts

print "root$".green
print " apt-get install letsencrypt -t jessie-backports".white
puts

print "root$".green
print " certbot --pre-hook 'service nginx stop' --post-hook 'service nginx start' certonly -n --standalone -d #{ web_domain } --agree-tos --email admin@#{ web_domain }".yellow
puts
puts

print "root$".green
print " cp /etc/letsencrypt/live/#{ web_domain }/privkey.pem #{ ssl_path }".yellow
puts

print "root$".green
print " cp /etc/letsencrypt/live/#{ web_domain }/fullchain.pem #{ ssl_path }".yellow
puts

print "root$".green
print " chown rails:rails #{ ssl_path }/*".yellow
puts
puts

print "root$".green
print " touch lets_encript.sh".yellow
puts

print "root$".green
print " [EDIT] lets_encript.sh".yellow
puts

puts """
echo '==============================================================================='
date
certbot renew --pre-hook 'service nginx stop' --post-hook 'service nginx start'
cp /etc/letsencrypt/live/#{ web_domain }/privkey.pem #{ ssl_path }
cp /etc/letsencrypt/live/#{ web_domain }/fullchain.pem #{ ssl_path }
chown  rails:rails #{ ssl_path }/*
""".cyan

print "root$".green
print " crontab -e".yellow
puts

print " [EDIT] /var/spool/cron/crontabs/root".white
puts

puts """
58 11,23 * * * /bin/bash -l -c 'source lets_encript.sh >> #{ shared_logs_path }/letsencrypt.log 2>> #{ shared_logs_path }/letsencrypt.errors.log'
""".cyan

print "root$".green
print " crontab -l".yellow
puts
puts

puts "DeployTool config:".blue

puts """
ssl:
  private_key: privkey.pem
  bundle_crt: fullchain.pem
""".red
    end
  end
end
