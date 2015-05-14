# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

user = User.create! email: "r-fujiwara@nekojarashi.com", password: "password", password_confirmation: "password"

100.times do |i|
  Post.create! user_id: user.id, title: "http://stackoverflow.com/questions/#{(rand * i * 1000).to_i}/bat-file-write-a-new-variable-to-a-msl-txt-file", content: "fugafuga-#{i}", url: "http://stackoverflow.com/questions/#{(rand * i * 1000).to_i}/bat-file-write-a-new-variable-to-a-msl-txt-file"
end

