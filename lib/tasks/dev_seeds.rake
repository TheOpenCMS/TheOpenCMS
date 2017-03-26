require 'colorize'
namespace :dev_seeds do
  # rake dev_seeds:fakes
  desc "Create some entities for developement"
  task fakes: :environment do
    Rake::Task["db:bootstrap"].invoke

    create_admin_user
    create_registration_request
  end

  private

  def create_admin_user
    User.create!(
      username: 'TheOpenCMS Admin',
      password: 'qwerty',
      password_confirmation: 'qwerty',
      email: 'admin@theopencms.org'
    )

    puts 'Admin user has been created'.yellow
  end

  def create_registration_request!
    EmailRegistrationRequest.create(email: 'new_user@theopencms.com')
    puts 'Registration Request has been created'.yellow
  end
end
