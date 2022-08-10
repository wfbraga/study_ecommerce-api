FactoryBot.define do
  factory :category do
    # Para que cada vez que for gerado uma categoria, ela tenha um nome diferente
    # esamos o metodo sequence do proprio FactoryBot
    name { Faker::Commerce.product_name }
  end
end
