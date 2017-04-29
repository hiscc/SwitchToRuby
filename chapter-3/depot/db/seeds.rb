# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

P.create(:title => 'Programming Ruby 1.9', :description => %{
  <p> Ruby list </p>
  }, :image_url => '/images/ruby.jpg', :price => 49.5)
