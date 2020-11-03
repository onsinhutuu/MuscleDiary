FactoryBot.define do
  factory :muscle do
    set_count { '4' }
    weight { '3' }
    rep { '2' }
    memo { Faker::Lorem.characters(number: 5) }
    work_tag { '#まじか'}
    start_time { '2020-10-20' }
    user
    part
    after(:create) do |muscle|
      create_list(:tag, 3, muscles: [muscle])
    end
  end
end
