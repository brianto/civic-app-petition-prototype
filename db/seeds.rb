# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

constant = Constants.create \
  :site_title => "Everyday City People",
  :goal => 10

p = Petition.create :title => "Bro Code #2345207", :statement => "No fucking bitches before the hackathon"
r = Resident.create :name => "DrunkMcAndres"
s = Signature.create

p1 = Petition.create :title => "Sunglasses", :statement => "You know if you leave your sunglasses at your bro's house, your bro's penis gets to wear them!"
r1 = Resident.create :name => "DrunkMcAndres"
s1 = Signature.create

p2 = Petition.create :title => "Counting", :statement => "If you don't know how to count, just say it..."
r2 = Resident.create :name => "DrewBitchboyFilipski"
s2 = Signature.create
s3 = Signature.create


s.petition = p
s.resident = r
s.save

s1.petition = p1
s1.resident = r1
s1.save

s2.petition = p2
s2.resident = r2
s2.save

s3.petition = p2
s3.resident = r1
s3.save