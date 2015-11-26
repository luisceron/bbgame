# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# set :environment, 'development'

# set :output, "/vagrant/log/whenever.log" # Uncomment for tests

every 1.minute do
  # command "/bin/bash -l -c 'cd /vagrant && rails runner -e development '\''Pred::PredFixture.out_of_date_fixture'\'''"
  command "/bin/bash -l -c 'cd /vagrant && rails runner -e development '\''Task.out_of_date_fixture'\'''"
end

every 1.minute do
  command "/bin/bash -l -c 'cd /vagrant && rails runner -e development '\''User::User.verifyConfirmedEmails'\'''"
end

# every 1.minute do
#   rake 'app:out_of_date_fixture', environment: 'development'
# end
