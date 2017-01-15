# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts
print "Create users:"

10.times do |index|
  User.create!(
    email: FFaker::Internet.email,
    password: "qwerty#{ index.next }",
    password_confirmation: "qwerty#{ index.next }"
  )
  print '.'
end

puts
print "Create notes:"

User.all.each do |user|
  10.times do
    user.notes.create!(
      title: FFaker::Lorem.sentence,
      content: FFaker::Lorem.paragraph(3),
      created_at: Time.now - (rand*100000).to_i.minutes
    )
    print '.'
  end
end

puts
