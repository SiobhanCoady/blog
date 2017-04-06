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

categories = Category.all

20.times do
  Post.create title: Faker::Hipster.sentence(4),
              body: Faker::Hipster.paragraph(75),
              category: categories.sample
end

posts = Post.all

posts.each do |p|
  rand(0..5).times do
    p.comments.create({
      body: Faker::Hipster.paragraph(10)
      })
  end
end

comments_count = Comment.count

puts Cowsay.say 'Created 20 questions', :elephant
puts Cowsay.say "Created #{comments_count} comments", :elephant
