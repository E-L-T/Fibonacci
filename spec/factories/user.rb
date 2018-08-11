
FactoryBot.define do
    factory :user do
      email 'test@mail.com'
      password 'password'
      state 'uncompleted'
      pdl 'Point 2'
      first_name 'John'
      last_name 'Richard'
      street_number '2'
      street_name 'grande rue'
      zip_code '78110'
      city 'Chatou'
      situation 1
    end
  end
