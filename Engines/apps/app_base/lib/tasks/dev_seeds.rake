namespace :dev_seeds do
  # rake dev_seeds:fakes
  desc "Create some entities for developement"
  task fakes: :environment do
    Rake::Task["db:bootstrap"].invoke

    users_count = ENV.fetch('USERS', 5).to_i
    articles_count = ENV.fetch('ARTICLES', 50).to_i

    create_admin_user!
    create_regular_users!(users_count)
    create_registration_request!
    create_one_time_login_link!

    admin = User.first
    create_articles!([admin], articles_count)

    users = User.where("id > 2").to_a
    create_articles!(users, articles_count)
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
        email: "user-#{i.next}@theopencms.org"
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

  def create_articles!(users, articles_count = 50)
    users.each do |user|
      puts "We create Articles for User #{user.id}".red
      articles_count.times do |i|
        article = Article.new(
          user: user,
          title: FFaker::Lorem.sentence[0..200],
          raw_intro: FFaker::Lorem.sentences(2).join(' '),
          raw_content: fake_content(15)
        )
        article.content_processing_for(user)
        article.state = %i[ draft published deleted ].sample
        article.save!
        puts 'Article has been created'.green
      end # articles_count
    end # users
  end

  def fake_content(amount = 5)
    content = []
    amount.times do |i|
      content << FFaker::Lorem.sentence
      content << <<-TXT_STRING
## An Amazing Header

### Sub header

http://example.ru *ITALIC* **BOLD** ~~DELETED~~ _UNDERLINE_ ==highlighted== 2<sup>(nd)<sup>

```python
# more python code
```

`some code` [LINK TEXT](http://example.com) ![IMG ALT](https://dummyimage.com/100x30/db0fdb/0011ff.png "Img title") ![](https://dummyimage.com/100x30/db0fdb/0011ff.png "Img title")

> _blockquote_ text
> blockquote **text**
> blockquote text

TXT_STRING
      content << ruby_code
      content << FFaker::Lorem.sentence
    end

    content.join(" \n")
  end

  def ruby_code
    "```ruby\n" + File.read("#{__dir__}/ruby_code_sample.rb") + "\n```"
  end
end
