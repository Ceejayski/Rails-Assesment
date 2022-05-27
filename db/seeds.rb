# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..20).each do |id|
  player = Player.create!(
    first_name: Faker::Name.name,
    last_name: Faker::Name.name,
    number: Faker::Number.between(from: 0, to: 99)
  )
  player.image.attach(
    io: File.open(Rails.root.join('vendor/sample.jpg')),
    filename: 'sample.jpg',
    content_type: 'image/jpg'
  )
end
