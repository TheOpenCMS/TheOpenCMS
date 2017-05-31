class DeployKit
  def db_create
    db_create_psql  if has_psql?
    db_create_mysql if has_mysql?
  end

  def db_create_psql
    db_user = config.db.username
    db_name = config.db.database

    grant_all = "GRANT ALL PRIVILEGES ON DATABASE #{db_name} TO #{db_user};"

    to_exec_1 = ssh_escape <<-EOS
      su -s /bin/bash -l postgres -c 'createdb -E UTF8 -O #{db_user} #{db_name}'
    EOS

    to_exec_2 = ssh_escape <<-EOS
      su -s /bin/bash -l postgres -c 'psql -U postgres -c \\"#{grant_all}\\"'
    EOS

    sudo_remote_exec to_exec_1
    sudo_remote_exec to_exec_2
  end

  def db_create_mysql
    db_user = config.db.username
    db_name = config.db.database

    to_exec_1 = <<-EOS
      mysql -D mysql -r -B -N -e \\"CREATE DATABASE #{db_name} CHARACTER SET utf8 COLLATE utf8_general_ci;\\"
    EOS

    to_exec_2 = ssh_escape <<-EOS
      mysql -D mysql -r -B -N -e \\"GRANT ALL PRIVILEGES ON #{db_name}.* TO '#{db_name}'@'localhost' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0\\"
    EOS

    sudo_remote_exec to_exec_1
    sudo_remote_exec to_exec_2
  end
end
