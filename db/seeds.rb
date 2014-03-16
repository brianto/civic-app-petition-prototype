# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p = Petition.create :title => "Bro Code #2345207", :statement => "No fucking bitches before the hackathon"
r = Resident.create :name => "DrunkMcAndres"
s = Signature.create

p1 = Petition.create :title => "Sunglasses", :statement => "You know if you leave your sunglasses at your bro's house, your bro's penis gets to wear them!"
r1 = Resident.create :name => "DrunkMcAndres"
s1 = Signature.create

s.petition = p
s.resident = r
s.save

s1.petition = p1
s1.resident = r1
s1.save

constant = Constants.create \
  :site_title => "Everyday City People",
  :goal => 1000
