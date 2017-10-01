# start: whenever --update-crontab
# stop: whenever --clear-crontab
# check: crontab -l

# Learn more: http://github.com/javan/whenever

rails_root = File.expand_path('../..', __FILE__)

set :rails_root, rails_root
set :environment, :development

set :output, {
  standard: "#{ rails_root }/log/cron.log",
  error:    "#{ rails_root }/log/cron.errors.log"
}

job_type :rake,   "cd :rails_root && RAILS_ENV=:environment bin/rake :task :output"
job_type :runner, "cd :rails_root && bin/rails runner -e :environment ':task' :output"

every 5.minute do
  rake 'ts:index'
end

every :monday, at: '00:01am' do
  rake 'letsencrypt:reissue_cert'
end
