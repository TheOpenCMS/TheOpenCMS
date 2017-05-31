class DeployKit
  BASE_DB_DUMPS_PATH = '~/DUMPS'

  def remote_db_dumps_path
    path = config.dump.db.from.to_s
    path.length > 0 ? path : BASE_DB_DUMPS_PATH
  end

  def local_db_dumps_path
    path = config.dump.db.to.to_s
    path.length > 0 ? path : BASE_DB_DUMPS_PATH
  end

  def dump_db
    dump_db_psql  if has_psql?
    dump_db_mysql if has_mysql?
  end

  def dump_db_psql
    dump_db_mkdirs

    port    = config.db.port || '5432'
    host    = config.db.host
    db_user = config.db.username
    pass    = config.db.password
    db_name = config.db.database

    access_params = [host, port, db_name, db_user, pass].join ':'

    remote_exec [
      "rm -rf ~/.pgpass",
      "echo #{ access_params } > ~/.pgpass",
      "chmod 0600 ~/.pgpass"
    ]

    file_name = db_local_file_name(:pq)

    remote_exec [
      "cd #{ remote_db_dumps_path }",
      "pg_dump --format=custom --host=#{ host } --username=#{ db_user } --file=#{ file_name } #{ db_name }",
      "rm -rf ~/.pgpass",
      "ls -al #{ remote_db_dumps_path }"
    ]

    local_file  = "#{ local_db_dumps_path }/#{ file_name }"
    remote_file = "#{ remote_db_dumps_path }/#{ file_name }"

    ssh_addr = "#{ config.ssh.user.deployer.login }@#{ config.ssh.user.deployer.domain }"
    copy_cmd = "scp #{ ssh_addr }:#{ remote_file } #{ local_file }"
    local_exec copy_cmd

    puts "POSTGRES: pg_restore -h #{ host } -d #{ db_name } -U #{ db_user } #{ local_file }".green
  end

  def dump_db_mysql
    dump_db_mkdirs

    port    = config.db.port
    host    = config.db.host
    db_user = config.db.username
    pass    = config.db.password
    db_name = config.db.database

    file_name = db_local_file_name(:mysql)

    except_table = '' # "--ignore-table=#{ db_name }.logs"
    dont_care_about_locks = '--lock-tables=false'

    opts = "-u #{ db_user } -p#{ pass } #{ db_name } #{ except_table } #{ dont_care_about_locks } > #{ remote_db_dumps_path }/#{ file_name }"

    puts "mysqldump #{ opts }".green
    remote_exec "mysqldump #{ opts }"

    local_file  = "#{ local_db_dumps_path }/#{ file_name }"
    remote_file = "#{ remote_db_dumps_path }/#{ file_name }"

    ssh_addr = "#{ config.ssh.user.deployer.login }@#{ config.ssh.user.deployer.domain }"
    copy_cmd = "scp #{ ssh_addr }:#{ remote_file } #{ local_file }"
    local_exec copy_cmd

    puts "MYSQL: mysql -u LOCAL_BD_USER -pPASSWORD123 LOCAL_DB_NAME < #{ local_file }"
  end

  def db_local_file_name(db_type)
    [config.app.name, config.db.database, Time.now.strftime("%Y_%m_%d_%H_%M"), db_type, :sql].join('.')
  end

  def dump_db_mkdirs
    remote_exec "mkdir -p #{ remote_db_dumps_path }"
    local_exec  "mkdir -p #{ local_db_dumps_path }"
  end
end
