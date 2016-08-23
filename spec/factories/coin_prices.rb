# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coin_price do
    currency "MyString"
    ask "9.99"
    bid "9.99"
    avg_24h "9.99"
    volume_btc "9.99"
    volume_percent "9.99"
  end
end
