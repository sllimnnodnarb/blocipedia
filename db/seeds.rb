5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end
users = User.all

5.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Name.name,
    body: Faker::Company.bs
  )
end
wikis = Wiki.all

puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "Seed finished"
puts "Some seeds fell beside the road, and the birds came and ate them up..."
