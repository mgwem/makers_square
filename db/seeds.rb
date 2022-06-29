# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@example.com',
  password: 'ccabcd',
)

12.times do |n|
  Member.create!(
    email: "test#{n + 1}@example.com",
    name: "テストユーザー#{n + 1}",
    password: "bbabcd",
    introduction: "テストユーザー#{n + 1}です。",
    website_info: "他のサイト(http:example.com)でテストユーザー#{n + 1}の作品を販売しています。",
  )
end

genres = Genre.create!([
  {name: "パーツアクセサリー"},
  {name: "ビーズ"},
  {name: "レジン"},
  {name: "粘土"},
  {name: "フェルト"},
  {name: "ソーイング"},
  {name: "刺繍"},
  {name: "編み物"},
  {name: "キルト"},
  {name: "ペーパークラフト"},
  {name: "フラワークラフト"},
  {name: "プラバン"},
  {name: "DIY"},
  {name: "その他"},
])