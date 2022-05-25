FactoryBot.define do
  factory :category do
    # Para que cada vez que for gerado uma categoria, ela tenha um nome diferente
    # esamos o metodo sequence do proprio FactoryBot
    sequence(:name) { |n| "Category #{n}" }
  end
end
