puts 'Clearing database...'
Quote.destroy_all
User.destroy_all
Company.destroy_all
puts 'Database cleared.'

puts 'Seeding database...'
ActiveRecord::Base.transaction do
  company1 = Company.create!(name: 'kpmg')
  company2 = Company.create!(name: 'pwc')

  User.create!(email: 'accountant@kpmg.com', password: 'password', company: company1)
  User.create!(email: 'manager@kpmg.com', password: 'password', company: company1)
  User.create!(email: 'eavesdropper@pwc.com', password: 'password', company: company2)

  Quote.create!(name: 'First quote.', company: company1)
  Quote.create!(name: 'Second quote.', company: company1)
  Quote.create!(name: 'Third quote.', company: company1)
end
puts 'Database seeded.'
