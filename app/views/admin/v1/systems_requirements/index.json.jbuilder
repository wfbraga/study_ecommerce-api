json.systems_requirements do
  json.array! @systems_requirements, :id, :name, :operational_system, :storage, :processor, :memory
end