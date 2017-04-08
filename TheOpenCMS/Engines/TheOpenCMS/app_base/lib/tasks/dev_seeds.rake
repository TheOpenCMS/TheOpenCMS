namespace :dev_seeds do
  # rake dev_seeds:fakes
  desc "Create some entities for developement"
  task fakes: :environment do
    Rake::Task["db:bootstrap"].invoke
    users_count = ENV.fetch('USERS', 5).to_i

    create_admin_user!
    create_regular_users!(users_count)
    create_registration_request!
    create_one_time_login_link!
  end

  private

  def create_admin_user!
    user = User.new(
      username: 'TheOpenCMS Admin',
      password: 'qwerty',
      password_confirmation: 'qwerty',
      email: 'admin@theopencms.org'
    )
    user.skip_confirmation!
    user.save!
    puts 'Admin user has been created'.yellow
  end

  def create_regular_users!(amount = 5)
    amount.times do |i|
      user = User.new(
        username: "User #{i.next}",
        password: 'qwerty',
        password_confirmation: 'qwerty',
        email: "user-#{i.next}@exmple.com"
      )
      user.skip_confirmation!
      user.save!
      puts 'Regular user has been created'.yellow
    end

  end

  def create_registration_request!
    EmailRegistrationRequest.create(email: 'new_user@test_email.com')
    puts 'Registration Request has been created'.yellow
  end

  def create_one_time_login_link!
    OnetimeLoginLink.create(email: 'new_user@test_email.com')
    puts 'One Time Login link has been created'.yellow
  end
end
