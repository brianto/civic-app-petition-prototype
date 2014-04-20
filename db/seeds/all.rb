# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_GOAL_THRESHOLD = 10

constant = Constants.create \
  :site_title => "Everyday City People",
  :site_description => <<EOF,
Everyday City People aims to provide a platform"
for local change, where residents can join voices and better our community.
EOF
  :goal => DEFAULT_GOAL_THRESHOLD,
  :resident_intro => "Resident Intro"

