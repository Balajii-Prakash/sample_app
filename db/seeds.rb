# Create a main sample user.
User.create!(
  name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true
)

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name:  name,
    email: email,
    password:              password,
    password_confirmation: password
  )
end

users = User.order(:created_at).last(6)

50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
