andres = Resident.create :name => "DrunkMcAndres"
andrew = Resident.create :name => "DrewBitchboyFilipski"

brian = Politician.create :name => "SimplyBrian"

User.create \
  :email => "andres@andres.com",
  :password => "Andres1",
  :password_confirmation => "Andres1",
  :role => andres

User.create \
  :email => "andrew@andrew.com",
  :password => "Andrew1",
  :password_confirmation => "Andrew1",
  :role => andrew

User.create \
  :email => "brian@brian.com",
  :password => "Brian1",
  :password_confirmation => "Brian1",
  :role => brian

brocode = Petition.create \
  :title => "Bro Code #2345207",
  :statement => "No fucking bitches before the hackathon",
  :resident => andres

sunglasses = Petition.create \
  :title => "Sunglasses",
  :statement => "You know if you leave your sunglasses at your bro's house, your bro's penis gets to wear them!",
  :resident => andres

counting = Petition.create \
  :title => "Counting",
  :statement => "If you don't know how to count, just say it...",
  :resident => andrew

Signature.create \
  :petition => sunglasses,
  :resident => andrew

Signature.create \
  :petition => counting,
  :resident => andres