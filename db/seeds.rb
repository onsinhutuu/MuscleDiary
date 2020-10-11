# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
	email: 'test@test.com',
	password: 'testtest'
	)
Big.create!(
  [
    {
      name: '背中',
    },
    {
      name: '胸',
    },
    {
      name: '脚',
    },
    {
      name: '肩',
    },
    {
      name: '上腕二頭筋',
    },
    {
      name: '上腕三頭筋',
    }
  ]
)