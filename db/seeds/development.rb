
# Create the basic developer profiles

# Build the Roles
andres = Resident.create :name => "Andres Ruiz"
andrew = Resident.create :name => "Andrew Filipski"
brian = Politician.create :name => "Brian To"

# Build the users
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

petition_list = []
# Build the signatures
(1..20).each do |number|
  signer = nil
  if(number % 2 == 0)
    signer = andres
  else
    signer = andrew
  end


  petition = Petition.create \
    :title => "Petition " << number.to_s,
    :statement => "Lorem ipsum dolor sit amet, vide "\
    "intellegam an sea, ut postea quaeque duo. Nostrud"\
    " temporibus ei vix, mea ut tibique theophrastus.",
    :resident => signer

  petition_list << petition
end

# Build 40 random users for signing petitions

(1..40).each do |number|
  user = Resident.create :name => "User " << number.to_s
  User.create \
  :email => "user" << number.to_s << "@user.com",
  :password => "Password1",
  :password_confirmation => "Password1",
  :role => user

  petition_list.each do |petition|
    Signature.create \
      :petition => petition,
      :resident => user
  end

end

