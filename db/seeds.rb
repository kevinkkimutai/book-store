require 'faker'
Faker::Config.locale = :en # Set Faker locale to English
puts "seeding......"
10.times do
    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: '1111' # Set password directly to '1111'
    )
  end

  5.times do
    Category.create!(
      name: Faker::Book.genre,
      description: Faker::Lorem.sentence
    )
  end

50.times do
    Book.create!(
      title: Faker::Book.title,
      description: Faker::Lorem.sentence,
      price: Faker::Commerce.price,
      author: Faker::Book.author,
      user_id: User.pluck(:id).sample,
      category_id: Category.pluck(:id).sample
    )
  end
  
  5.times do
    Category.create!(
      name: Faker::Book.genre,
      description: Faker::Lorem.sentence
    )
  end
  
  20.times do
    Order.create!(
      user_id: User.pluck(:id).sample,
      book_id: Book.pluck(:id).sample,
      quantity: Faker::Number.between(from: 1, to: 5),
      total_price: Faker::Number.between(from: 10, to: 50) * 100
    )
  end
  
  
puts "Done seeding...."