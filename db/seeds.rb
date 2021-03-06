# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Channel.create(name: 'N00b Neighborhood', description: 'Come try it out and get some TellyTokens', actor_allowed_time: 20)
Channel.create(name: 'Creativity Corner', description: 'Showcase your skills', actor_allowed_time: 120)
Channel.create(name: 'Politics Place', description: 'Got an idea to propose or a frustration to vent?', actor_allowed_time: 30)
Channel.create(name: 'Religion Rink', description: "It\'s always good hear others\' opinions, but let\'s remember to keep it civil, aight?", actor_allowed_time: 120)
Channel.create(name: 'Telly Tunnel', description: 'Where the admins lurk. Report issues and discuss the site here.', actor_allowed_time: 30)
