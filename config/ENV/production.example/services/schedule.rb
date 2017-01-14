# http://en.wikipedia.org/wiki/Cron
# Learn more: http://github.com/javan/whenever

# START: whenever --update-crontab --load-file config/ENV/services/schedule.rb --set 'environment=development'
# SHOW:  crontab -l
# STOP:  whenever --clear-crontab  --load-file config/ENV/services/schedule.rb --set 'environment=development'

set :rails_root, path

set :output, {
  standard: "#{ rails_root }/log/cron.log",
  error:    "#{ rails_root }/log/cron.errors.log"
}

job_type :rake,   "cd :rails_root && RAILS_ENV=:environment bin/rake :task :output"
job_type :runner, "cd :rails_root && bin/rails runner -e :environment ':task' :output"

every 1.minute do
  rake 'ts:index'
end

every 1.minute do
  runner 'NotesRandomWorker.perform_in(2.minutes)'
end
