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

andres = Resident.create :name => "DrunkMcAndres"
andrew = Resident.create :name => "DrewBitchboyFilipski"

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
