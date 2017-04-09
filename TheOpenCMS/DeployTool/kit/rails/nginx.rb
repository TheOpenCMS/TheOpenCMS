# NOTE: chmod 755 www

# MAC: /usr/local/bin/nginx
# DEBIAN: /etc/init.d/nginx

# MAC: /usr/local/etc/nginx/nginx.conf
# DEBIAN: /etc/nginx/nginx.conf

# MAC: /usr/local/var/run/nginx.pid
# DEBIAN: /usr/local/nginx/logs/nginx.pid
#
# nginx -s quit
# nginx -s stop
# nginx -s reload

class DeployKit
  def nginx_config_copy
    template_upload \
      "services/nginx.config", \
      "#{ app_services_files_path }/nginx.config"
  end

  def nginx_start
    sudo_remote_exec nginx_bin
  end

  def nginx_restart
    case config.tools.os
      when 'mac'
        sudo_remote_exec "#{ nginx_bin } -s reload"
      when 'debian'
        sudo_remote_exec "#{ nginx_bin } restart"
      else
        raise 'NginX pid path undefined'
    end
  end

  def nginx_info
    puts "EDIT: #{ nginx_config_path }".red
    puts "ADD: include #{ app_services_files_path }/nginx.config;".green
  end

  def nginx_bin
    case config.tools.os
      when 'mac'
        '/usr/local/bin/nginx'
      when 'debian'
        '/etc/init.d/nginx'
      else
        raise 'NginX bin path undefined'
    end
  end

  def nginx_config_path
    case config.tools.os
      when 'mac'
        '/usr/local/etc/nginx/nginx.conf'
      when 'debian'
        '/etc/nginx/nginx.conf'
      else
        raise 'NginX config path undefined'
    end
  end

  def nginx_pid
    case config.tools.os
      when 'mac'
        '/usr/local/var/run/nginx.pid'
      when 'debian'
        '/usr/local/nginx/logs/nginx.pid'
      else
        raise 'NginX pid path undefined'
    end
  end
end
