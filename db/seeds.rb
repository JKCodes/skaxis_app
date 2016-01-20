User.create!(name: "Example User",
             email: "test@example.com",
             status: "Example Status",
             description: "Example Description",
             password: "secret",
             password_confirmation: "secret",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@example.com"
  status = "This is the status update for #{name}."
  description = "This is a not-so-lengthy description for #{name}.  This user's number is #{n+2}."
  password = "secret"
  User.create!(name: name,
               email: email,
               status: status,
               description: description,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

