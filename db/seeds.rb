###################################################################################
###########################  Destroy all existing data  ###########################
###################################################################################

if Rails.env.development?
  Rake::Task['db:environment:set'].invoke(['RAILS_ENV=development'])
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:schema:load'].invoke
end

###################################################################################
###########################  Create dev user  ###########################
###################################################################################


lukas = User.create(
  username: "lcorbitt",
  email: "lukas@example.com",
  password: "Password1",
  role: User::ADMIN
)

###################################################################################
###########################  Create employees  ###########################
###################################################################################

10.times do
  User.create(
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: 'Password1',
    role: User::EMPLOYEE
  )
end

###################################################################################
###########################  Create Projects  ###########################
###################################################################################

10.times do
  Project.create(
    user: lukas,
    name: Faker::Hipster.sentence,
    description: Faker::Hipster.sentences.join(' ')
  )
end

###################################################################################
###########################  Create Tickets  ###########################
###################################################################################

50.times do
  Ticket.create(
    user: User.all.sample(),
    project: Project.all.sample(),
    title: Faker::Hipster.sentence,
    description: Faker::Hipster.sentences.join(' '),
    priority: Ticket.priorities.map { |k,v| v }.sample(),
    status: Ticket.statuses.map { |k,v| v }.sample()
  )
end

puts "#{User.all.size} User records created."
puts "#{Project.all.size} Project records created."
puts "#{Ticket.all.size} Ticket records created."

