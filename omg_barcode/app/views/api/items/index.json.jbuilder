@items.each do |item|
  json.set! item.upc do
    json.extract! item, :id, :name, :upc
  end
end
