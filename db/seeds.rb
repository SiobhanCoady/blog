Category.create(
  [
    {name: 'Technology'},
    {name: 'Travel'},
    {name: 'Photography'},
    {name: 'Literature'},
    {name: 'Development'},
    {name: 'Music'}
  ]
)

10.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: '12345678',
              password_confirmation: '12345678'
end
puts Cowsay.say 'Created 10 users', :elephant

20.times do
  category = Category.all.sample
  user = User.all.sample
  Post.create title: Faker::Hipster.word,
              body: Faker::Hipster.paragraph(75),
              category_id: category.id,
              user_id: user.id
end

posts = Post.all

posts.each do |p|
  rand(0..5).times do
    user = User.all.sample
    p.comments.create({
      body: Faker::Hipster.paragraph(10),
      user_id: user.id
      })
  end
end

comments_count = Comment.count

puts Cowsay.say 'Created 20 posts', :elephant
puts Cowsay.say "Created #{comments_count} comments", :elephant
