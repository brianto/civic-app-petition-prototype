roles = Hash.new
petitions = Hash.new

# Create named users
roles[:andres] = Resident.create :name => "Andres Ruiz"
roles[:andrew] = Resident.create :name => "Andrew Filipski"
roles[:brian]  = Politician.create :name => "Brian To"

User.create \
  :email => "andres@andres.com",
  :password => "Andres1",
  :password_confirmation => "Andres1",
  :role => roles[:andres]

User.create \
  :email => "andrew@andrew.com",
  :password => "Andrew1",
  :password_confirmation => "Andrew1",
  :role => roles[:andrew]

User.create \
  :email => "brian@brian.com",
  :password => "Brian1",
  :password_confirmation => "Brian1",
  :role => roles[:brian]

# Create zombie users
zombie_residents = 1.upto(DEFAULT_GOAL_THRESHOLD).map do |n|
  resident = Resident.create :name => "User ##{n}"

  User.create \
    :email => "user#{n}@user.com",
    :password => "Password1",
    :password_confirmation => "Password1",
    :role => resident

  resident
end

# Create petition cases
petitions[:goal_reached] = Petition.create \
  :title => "Who let the dogs out?",
  :statement => "goal threshold reached",
  :resident => roles[:andres]

zombie_residents.each do |resident|
  Signature.create \
    :petition => petitions[:goal_reached],
    :resident => resident
end

petitions[:one_signature] = Petition.create \
  :title => "Lonely nights",
  :statement => "one signature",
  :resident => roles[:andres]

petitions[:responded] = Petition.create \
  :title => "VIP, they're calling me tonight",
  :statement => "has politician response",
  :resident => roles[:andres]

zombie_residents.each do |resident|
  Signature.create \
    :petition => petitions[:responded],
    :resident => resident
end

Response.create \
  :petition => petitions[:responded],
  :politician => roles[:brian],
  :statement => "C.C. Catch 4ever"

petitions[:reported] = Petition.create \
  :title => "Public penis vacuums",
  :statement => "ban hammer",
  :resident => roles[:andrew]

Report.create \
  :petition => petitions[:reported],
  :resident => roles[:andres]

petitions[:popular_reported] = Petition.create \
  :title => "Indecent exposure does not apply to sexy people",
  :statement => "enough signatures, but ban hammer",
  :resident => roles[:andrew]

zombie_residents.each do |resident|
  Signature.create \
    :petition => petitions[:popular_reported],
    :resident => resident
end

Report.create \
  :petition => petitions[:popular_reported],
  :resident => roles[:andres]
