json.products do
  json.array! @products do |product|
    json.partial! product
    json.partian! product.productable
  end
end