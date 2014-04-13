# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

constant = Constants.create \
  :site_title => "Everyday City People",
  :site_description => "pending description",
  :goal => 10,
  :resident_intro => "Resident Intro"

