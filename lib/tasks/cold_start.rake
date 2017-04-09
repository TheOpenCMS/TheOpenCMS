namespace :cold_start do
  # rake cold_start:admin
  desc "Create the root user"
  task admin: :environment do
    create_admin_user!
  end

  private

  def create_admin_user!
    pass = Digest::MD5.hexdigest(Time.now.to_s)[0..8].upcase

    user = User.new(
      username: 'TheOpenCMS Admin',
      password: pass,
      password_confirmation: pass,
      email: 'admin@theopencms.org'
    )
    user.skip_confirmation!
    user.save!

    puts 'Admin user has been created'.yellow
    puts "Password: #{ pass }".red
  end
end
